const { GoogleGenerativeAI } = require("@google/generative-ai");
const { Octokit } = require("@octokit/rest");
const fs = require('fs');

// Initialize
const genAI = new GoogleGenerativeAI(process.env.GOOGLE_AI_KEY);
const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });

const SYSTEM_PROMPT = `
You are an expert Flutter/Node.js code reviewer for a software company. 

YOUR ROLE:
- Review code for bugs, performance issues, and best practices
- Focus on Flutter, Node.js, React, and MongoDB code
- Provide constructive, specific feedback
- Rate code quality from 1-10

[... rest of your training from Part 3 ...]

OUTPUT FORMAT for GitHub:
### 🤖 AI Code Review

**Overall Score:** X/10

#### ❌ Critical Issues
- Issue 1
- Issue 2

#### ⚠️ Warnings
- Warning 1

#### 💡 Suggestions
- Suggestion 1

#### ✅ Good Practices
- Good thing 1

**Recommendation:** APPROVE / REQUEST CHANGES / REJECT
`;

async function reviewCode() {
  try {
    // Get PR details from GitHub context
    const context = JSON.parse(fs.readFileSync(process.env.GITHUB_EVENT_PATH, 'utf8'));
    const { pull_request } = context;
    
    // Get changed files
    const { data: files } = await octokit.pulls.listFiles({
      owner: context.repository.owner.login,
      repo: context.repository.name,
      pull_number: pull_request.number,
    });

    // Filter code files only
    const codeFiles = files.filter(file => 
      file.filename.match(/\.(dart|js|jsx|ts|tsx)$/) &&
      file.status !== 'removed'
    );

    if (codeFiles.length === 0) {
      console.log('No code files to review');
      return;
    }

    // Get file contents
    let allCode = '';
    for (const file of codeFiles) {
      const { data: content } = await octokit.repos.getContent({
        owner: context.repository.owner.login,
        repo: context.repository.name,
        path: file.filename,
        ref: pull_request.head.sha,
      });
      
      const code = Buffer.from(content.content, 'base64').toString();
      allCode += `\n\n--- FILE: ${file.filename} ---\n${code}`;
    }

    // Send to AI for review
    const model = genAI.getGenerativeModel({ 
      model: "gemini-1.5-flash",
      systemInstruction: SYSTEM_PROMPT
    });

    const result = await model.generateContent(
      `Review this Pull Request:\n${allCode}`
    );
    
    const aiReview = result.response.text();

    // Post comment on PR
    await octokit.issues.createComment({
      owner: context.repository.owner.login,
      repo: context.repository.name,
      issue_number: pull_request.number,
      body: aiReview,
    });

    console.log('✅ AI Review posted successfully');

  } catch (error) {
    console.error('Error:', error);
    process.exit(1);
  }
}

reviewCode();
