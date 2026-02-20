const { GoogleGenerativeAI } = require("@google/generative-ai");
const { Octokit } = require("@octokit/rest");
const fs = require('fs');

// Initialize
const genAI = new GoogleGenerativeAI(process.env.GOOGLE_AI_KEY);
const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });

const SYSTEM_PROMPT = `You are an expert Flutter/Node.js/React code reviewer for a software company.

YOUR ROLE:
- Review code for bugs, performance issues, and best practices
- Focus on Flutter, Node.js, React, and MongoDB code
- Provide constructive, specific feedback with line numbers
- Rate code quality from 1-10

REVIEW CHECKLIST:
□ Code follows Flutter/Dart/Node.js best practices
□ Proper error handling
□ No memory leaks
□ Efficient state management
□ API calls optimized
□ Security vulnerabilities checked
□ Code is maintainable and readable
□ No hardcoded values
□ Follows DRY principle

OUTPUT FORMAT for GitHub (use markdown):
### 🤖 AI Code Review

**Overall Score:** X/10

#### ❌ Critical Issues
- Line X: [Issue description]

#### ⚠️ Warnings  
- Line X: [Warning description]

#### 💡 Suggestions
- [Suggestion]

#### ✅ Good Practices Found
- [Good practice]

**Recommendation:** APPROVE / REQUEST CHANGES / REJECT

---
*Powered by Google Gemini AI*`;

async function reviewCode() {
  try {
    console.log('🤖 Starting AI Code Review...');
    
    // Read GitHub event data
    const eventPath = process.env.GITHUB_EVENT_PATH;
    const event = JSON.parse(fs.readFileSync(eventPath, 'utf8'));
    
    const { pull_request, repository } = event;
    const owner = repository.owner.login;
    const repo = repository.name;
    const pullNumber = pull_request.number;

    console.log(`📋 Reviewing PR #${pullNumber} in ${owner}/${repo}`);

    // Get changed files
    const { data: files } = await octokit.pulls.listFiles({
      owner,
      repo,
      pull_number: pullNumber,
    });

    console.log(`📁 Found ${files.length} changed files`);

    // Filter code files only
    const codeFiles = files.filter(file => 
      file.filename.match(/\.(dart|js|jsx|ts|tsx|java|kt|py)$/) &&
      file.status !== 'removed' &&
      file.changes < 500 // Skip very large files
    );

    if (codeFiles.length === 0) {
      console.log('✅ No code files to review');
      await octokit.issues.createComment({
        owner,
        repo,
        issue_number: pullNumber,
        body: '### 🤖 AI Code Review\n\n✅ No reviewable code files found in this PR (or all files are too large).',
      });
      return;
    }

    console.log(`🔍 Reviewing ${codeFiles.length} code files...`);

    // Get file contents (limit to first 5 files to avoid token limits)
    let reviewContent = '# Files to Review:\n\n';
    const filesToReview = codeFiles.slice(0, 5);
    
    for (const file of filesToReview) {
      try {
        const { data: content } = await octokit.repos.getContent({
          owner,
          repo,
          path: file.filename,
          ref: pull_request.head.sha,
        });
        
        if (content.content) {
          const code = Buffer.from(content.content, 'base64').toString();
          const lines = code.split('\n').length;
          
          reviewContent += `\n## 📄 ${file.filename} (${lines} lines, ${file.changes} changes)\n\n`;
          reviewContent += '```' + getLanguage(file.filename) + '\n';
          reviewContent += code;
          reviewContent += '\n```\n';
        }
      } catch (error) {
        console.log(`⚠️  Could not fetch: ${file.filename} - ${error.message}`);
      }
    }

    if (filesToReview.length < codeFiles.length) {
      reviewContent += `\n\n_Note: Reviewed ${filesToReview.length} of ${codeFiles.length} files (limited for performance)_\n`;
    }

    // Send to AI for review
    console.log('🧠 Sending to Google AI for analysis...');
    
    const model = genAI.getGenerativeModel({ 
      model: "gemini-1.5-flash",
      systemInstruction: SYSTEM_PROMPT,
      generationConfig: {
        temperature: 0.3,
        maxOutputTokens: 2048,
      }
    });

    const result = await model.generateContent(reviewContent);
    const aiReview = result.response.text();

    console.log('✅ AI Review generated');

    // Post comment on PR
    await octokit.issues.createComment({
      owner,
      repo,
      issue_number: pullNumber,
      body: aiReview,
    });

    console.log('✅ Review posted to PR successfully!');

  } catch (error) {
    console.error('❌ Error during review:', error.message);
    console.error(error);
    
    // Try to post error to PR
    try {
      const eventPath = process.env.GITHUB_EVENT_PATH;
      const event = JSON.parse(fs.readFileSync(eventPath, 'utf8'));
      
      await octokit.issues.createComment({
        owner: event.repository.owner.login,
        repo: event.repository.name,
        issue_number: event.pull_request.number,
        body: `### 🤖 AI Code Review\n\n❌ **Error occurred during review**\n\n\`\`\`\n${error.message}\n\`\`\`\n\nPlease check the [GitHub Actions logs](https://github.com/${event.repository.owner.login}/${event.repository.name}/actions) for details.`,
      });
    } catch (e) {
      console.error('Could not post error comment:', e.message);
    }
    
    process.exit(1);
  }
}

// Helper function to detect language for syntax highlighting
function getLanguage(filename) {
  const ext = filename.split('.').pop();
  const langMap = {
    'dart': 'dart',
    'js': 'javascript',
    'jsx': 'javascript',
    'ts': 'typescript',
    'tsx': 'typescript',
    'java': 'java',
    'kt': 'kotlin',
    'py': 'python'
  };
  return langMap[ext] || '';
}

// Run the review
reviewCode();