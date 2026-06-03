#!/bin/bash
# Bash script to auto-generate commit messages using an AI model

# --- CONFIGURATION ---
API_KEY="Your API KEY here"
MODEL="Your preferred model here (e.g., gpt-oss-120b)"
MAX_TOKENS=500

# --- CHECKS ---
if [ -z "$API_KEY" ]; then
    echo "❌ Error: API_KEY is not set."
    exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Error: Not inside a Git repository."
    exit 1
fi

# --- GET GIT DIFF CONTEXT ---
# We add ':!package-lock.json' to prevent giant dependency files from blowing up our context
DIFF_OUTPUT=$(git diff --cached -- . ':!package-lock.json')
if [ -z "$DIFF_OUTPUT" ]; then
    echo "📦 Staging all local changes..."
    git add .
    DIFF_OUTPUT=$(git diff --cached -- . ':!package-lock.json')
    if [ -z "$DIFF_OUTPUT" ]; then
        echo "✨ Nothing to commit. Working tree clean."
        exit 0
    fi
fi

# --- SAFE WINDOWS SCALABILITY: USE A GENUINE TEMP FILE ---
# Write the massive diff string to a temporary physical file in the current directory
TEMP_DIFF_FILE=".git_diff_temp.txt"
echo "$DIFF_OUTPUT" > "$TEMP_DIFF_FILE"

# --- SAFELY BUILD JSON PAYLOAD USING --RAWFILE ---
# Reading from a real physical file handles infinite lengths flawlessly on Windows
PAYLOAD=$(jq -n \
  --arg model "$MODEL" \
  --arg max_tokens "$MAX_TOKENS" \
  --arg sys_content "You are an assistant that writes concise, clear Git commit messages. Provide ONLY the final commit message text, using conventional commit formatting, without wrapping it in markdown code blocks or explanations." \
  --rawfile diff_text "$TEMP_DIFF_FILE" \
  '{
    model: $model,
    messages: [
      {role: "system", content: $sys_content},
      {role: "user", content: ("Write a short, conventional commit message for the following git diff:\n" + $diff_text)}
    ],
    max_tokens: ($max_tokens | tonumber),
    temperature: 0.3
  }')

# Clean up the temporary file immediately so your workspace stays spotless
rm -f "$TEMP_DIFF_FILE"

# --- CALL AI MODEL ---
echo "🤖 Generating commit message..."
RESPONSE=$(curl -s https://api.cerebras.ai/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD")

COMMIT_MESSAGE=$(echo "$RESPONSE" | jq -r '.choices[0].message.content // empty')
COMMIT_MESSAGE=$(echo "$COMMIT_MESSAGE" | sed -e 's/^`*//' -e 's/`*$//' | xargs)

# --- VALIDATE RESPONSE ---
if [ -z "$COMMIT_MESSAGE" ] || [ "$COMMIT_MESSAGE" == "null" ]; then
    echo "❌ Error: Failed to generate commit message."
    exit 1
fi

# --- COMMIT & DISPLAY ---
git commit -m "$COMMIT_MESSAGE" >/dev/null 2>&1

echo "🔥 Done!"
git log -1 --stat --oneline