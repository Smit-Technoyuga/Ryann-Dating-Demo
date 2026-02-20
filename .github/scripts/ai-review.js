import { GoogleGenerativeAI } from "@google/generative-ai";
import { Octokit } from "@octokit/rest";

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
*AI Code Review powered by Google Gemini*`;

async function reviewCode() {
  try {
    console.log('🤖 Starting AI Code Review...');
    
    const owner = process.env.REPO_OWNER;
    const repo = process.env.REPO_NAME;
    const pullNumber = parseInt(process.env.PR_NUMBER);
    const headSha = process.env.PR_HEAD_SHA;

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
      file.filename.match(/\.(dart|js|jsx|ts|tsx|java|kt)$/) &&
      file.status !== 'removed' &&
      file.changes < 500 // Skip very large files
    );

    if (codeFiles.length === 0) {
      console.log('✅ No code files to review (or all files too large)');
      await octokit.issues.createComment({
        owner,
        repo,
        issue_number: pullNumber,
        body: '### 🤖 AI Code Review\n\n✅ No reviewable code files found in this PR.',
      });
      return;
    }

    console.log(`🔍 Reviewing ${codeFiles.length} code files...`);

    // Get file contents
    let reviewContent = '# Code Review Request\n\n';
    
    for (const file of codeFiles.slice(0, 5)) { // Limit to 5 files
      try {
        const { data: content } = await octokit.repos.getContent({
          owner,
          repo,
          path: file.filename,
          ref: headSha,
        });
        
        if (content.content) {
          const code = Buffer.from(content.content, 'base64').toString();
          reviewContent += `\n## File: ${file.filename}\n\`\`\`\n${code}\n\`\`\`\n`;
        }
      } catch (error) {
        console.log(`⚠️ Could not fetch content for ${file.filename}`);
      }
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

    console.log('✅ AI Review generated successfully');

    // Post comment on PR
    await octokit.issues.createComment({
      owner,
      repo,
      issue_number: pullNumber,
      body: aiReview,
    });

    console.log('✅ AI Review posted to PR');
    console.log('\n' + aiReview);

  } catch (error) {
    console.error('❌ Error:', error.message);
    
    // Post error comment to PR
    try {
      await octokit.issues.createComment({
        owner: process.env.REPO_OWNER,
        repo: process.env.REPO_NAME,
        issue_number: parseInt(process.env.PR_NUMBER),
        body: '### 🤖 AI Code Review\n\n❌ An error occurred during AI review. Please check the GitHub Actions logs.',
      });
    } catch (e) {
      console.error('Could not post error comment:', e.message);
    }
    
    process.exit(1);
  }
}

reviewCode();
