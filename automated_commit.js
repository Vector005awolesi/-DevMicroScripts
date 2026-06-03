#!/usr/bin/env node

import { execSync } from 'child_process';

// Your configurations hardcoded directly into the file
const API_KEY = "Your API KEY here";
const MODEL = "Your preferred model here (e.g., gpt-oss-120b)";
const MAX_TOKENS = 500;

const runCmd = (cmd) => {
  try {
    return execSync(cmd, { stdio: ['pipe', 'pipe', 'ignore'] }).toString().trim();
  } catch (e) {
    return null;
  }
};

async function main() {
  // Ensure we are inside a Git repo
  const isGit = runCmd('git rev-parse --is-inside-work-tree');
  if (isGit !== 'true') {
    console.error("❌ Error: Not inside a Git repository.");
    process.exit(1);
  }

  // Get changes while skipping the heavy package-lock.json
  let diffOutput = runCmd('git diff --cached -- . :!package-lock.json');

  if (!diffOutput) {
    console.log("📦 Staging all local changes...");
    runCmd('git add .');
    diffOutput = runCmd('git diff --cached -- . :!package-lock.json');
    
    if (!diffOutput) {
      console.log("✨ Nothing to commit. Working tree clean.");
      process.exit(0);
    }
  }

  console.log("🤖 Generating commit message...");

  try {
    const response = await fetch('https://api.cerebras.ai/v1/chat/completions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${API_KEY}`
      },
      body: JSON.stringify({
        model: MODEL,
        messages: [
          {
            role: "system", 
            content: "You are an assistant that writes concise, clear Git commit messages. Provide ONLY the final commit message text, using conventional commit formatting, without wrapping it in markdown code blocks or explanations."
          },
          {
            role: "user", 
            content: `Write a short, conventional commit message for the following git diff:\n${diffOutput}`
          }
        ],
        max_tokens: MAX_TOKENS,
        temperature: 0.3
      })
    });

    const data = await response.json();
    let commitMessage = data.choices?.[0]?.message?.content?.trim() || '';
    
    commitMessage = commitMessage.replace(/^`*|`*$/g, '').trim();

    if (!commitMessage || commitMessage === 'null') {
      throw new Error(JSON.stringify(data));
    }

    // Safely execute git commit behind the scenes
    const escapedMessage = commitMessage.replace(/"/g, '\\"');
    execSync(`git commit -m "${escapedMessage}"`, { stdio: 'ignore' });

    console.log("🔥 Done!");
    
    const logSummary = runCmd('git log -1 --stat --oneline');
    console.log(logSummary);

  } catch (error) {
    console.error("❌ Error: Failed to generate commit message.");
    console.error(error.message);
    process.exit(1);
  }
}

main();