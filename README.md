# ⚡ DevMicroScripts

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Open Source](https://img.shields.io/badge/Open%20Source-%E2%9D%A4-red)]()

A premium, actively growing collection of high-performance micro-scripts designed to automate repetitive developer workflows, bypass tedious configuration bottlenecks, and accelerate your daily development lifecycle.

Instead of manually running repetitive strings of terminal commands or wrestling with interactive wizard prompts, these scripts handle the heavy lifting instantly.

**✨ Note: This is an actively growing open-source repository! More time-saving scripts are constantly being added. We are actively looking for community contributions to expand this collection into the ultimate developer toolkit.**

---

## 📑 Table of Contents

1. [Available Scripts](#-available-scripts)
2. [Global Prerequisites](#️-global-prerequisites)
3. [Installation & Setup](#-installation--setup)
4. [Creating Terminal Shortcuts](#-creating-terminal-shortcuts-aliases)
5. [Usage Guide](#-usage-guide)
6. [Script Deep Dives](#-script-deep-dives)
7. [Troubleshooting](#-troubleshooting)
8. [Contributing](#-contributing)
9. [Code of Conduct](#️-strict-code-of-conduct)
10. [License](#-license)

---

## 🚀 Available Scripts

### 1. Automated Vite + Tailwind v4 Bootstrapper
Bypasses the sluggish, interactive `npm create` CLI prompts by programmatically scaffolding folders.

* **Available in:** `Node.js` & `Bash`
* **What it does:** Instantly creates a production-ready React + Vite project with Tailwind CSS v4 pre-configured
* **Time saved:** ~5-10 minutes per project setup
* **Perfect for:** Quick prototypes, hackathons, starting new projects

**Features:**
* Instantly builds a standard React + Vite directory structure
* Autogenerates an optimized `package.json` with the latest dependencies
* Injects `vite.config.js` with the official Tailwind v4 plugin
* Applies premium minimalist dark-mode global styles out of the box
* Runs a silent `npm install` to finish the setup automatically

### 2. AI-Powered Conventional Commits
Streams your repository's structural diff changes directly into an ultra-fast LLM engine to generate precise, semantic git commits.

* **Available in:** `Node.js` & `Bash`
* **What it does:** Analyzes your staged changes and generates intelligent, semantic commit messages automatically
* **Time saved:** ~2-3 minutes per commit (no more thinking about commit messages!)
* **Perfect for:** Teams following conventional commits, large projects, rapid development cycles

**Features:**
* **Token Defense Layer:** Programmatically ignores heavy `package-lock.json` modifications to preserve API bandwidth and lower costs
* **Zero-Dependency (Node):** Runs natively without needing `node_modules` or `.env` files
* **Buffer Immune (Bash):** Uses physical temporary file streams to bypass the Windows `Argument list too long` terminal limits
* **Semantic Accuracy:** Detects feature additions, bug fixes, breaking changes, and documentation updates

---

## 🛠️ Global Prerequisites

Before launching the scripts, ensure your workspace has the following global tools installed. These scripts run natively on **Windows (Git Bash)**, **macOS**, and **Linux**.

### Required Tools

1. **[Node.js](https://nodejs.org/)** — Version `v20.0.0` or higher
   - Required for the `.js` scripts
   - [Download the LTS version here](https://nodejs.org/)
   - Verify installation: `node --version`

2. **[Git / Git Bash](https://gitforwindows.org/)** — Latest stable version
   - Required for all scripts (Git commands are used under the hood)
   - On Windows, Git Bash allows you to run `.sh` scripts natively
   - Verify installation: `git --version`

### Optional Tools

3. **[jq](https://jqlang.github.io/jq/)** — A lightweight command-line JSON processor
   - Required **only** if you plan to use the `.sh` AI commit script
   - Used for parsing JSON responses from the AI API
   - Install via: `brew install jq` (macOS) or `choco install jq` (Windows with Chocolatey)
   - Verify installation: `jq --version`

---

## 📦 Installation & Setup

Follow these exact steps to clone the scripts to a permanent home on your machine and make them executable.

### Step 1: Clone the Repository

Choose a central directory on your computer (we recommend `~/Documents`) to store your automation suite:

```bash
cd ~/Documents
git clone https://github.com/YOUR_GITHUB_USERNAME/DevMicroScripts.git
cd DevMicroScripts
```

### Step 2: Configure Executable Permissions

If you are operating on Linux, macOS, or using Git Bash on Windows, grant absolute system permissions to make the scripts executable directly from the terminal:

```bash
chmod +x *.sh *.js
```

Or, if you prefer to be more selective:

```bash
chmod +x automated_commit.sh automated_commit.js
chmod +x automate_vite_build.sh automate_vite_build.js
```

### Step 3: Add Your API Key (For AI Commits)

If you are using the AI Automated Commit scripts, open the file (`automated_commit.js` or `automated_commit.sh`) in your code editor and replace the placeholder `API_KEY` string with your actual Cerebras or OpenAI API key.

**Example:**
```javascript
const API_KEY = "sk-proj-YOUR_ACTUAL_KEY_HERE";
```

---

## 🏎️ Creating Terminal Shortcuts (Aliases)

**This is the most important step!** Setting up terminal shortcuts lets you run scripts from anywhere without typing long file paths.

### For Bash (Linux / Git Bash on Windows)

1. Open your configuration file:

```bash
notepad ~/.bashrc    # Windows
nano ~/.bashrc       # macOS/Linux
```

2. Paste the following shortcuts at the bottom of the document:

```bash
# DevMicroScripts Shortcuts
alias qv4="node ~/Documents/DevMicroScripts/automate_vite_build.js"
alias qv4-sh="~/Documents/DevMicroScripts/automate_vite_build.sh"
alias gca="node ~/Documents/DevMicroScripts/automated_commit.js"
alias gca-sh="~/Documents/DevMicroScripts/automated_commit.sh"
```

3. Save the file and reload your terminal:

```bash
source ~/.bashrc
```

4. Verify the aliases work:

```bash
qv4 --help
gca --help
```

### For Zsh (macOS default)

1. Open your configuration file:

```bash
nano ~/.zshrc
```

2. Paste the same aliases as above.

3. Save and refresh:

```bash
source ~/.zshrc
```

4. Verify the aliases work:

```bash
qv4 --help
gca --help
```

### Understanding the Shortcuts

| Alias | What it does |
|-------|------------|
| `qv4` | Creates a new Vite + Tailwind project (Node.js version) |
| `qv4-sh` | Creates a new Vite + Tailwind project (Bash version) |
| `gca` | Generates an AI-powered git commit (Node.js version) |
| `gca-sh` | Generates an AI-powered git commit (Bash version) |

**Pro Tip:** Most developers prefer the Node.js versions (`qv4` and `gca`) since they're faster and require fewer dependencies. The Bash versions are there as alternatives.

---

## �️ Usage Guide

**Before using any scripts, make sure you've set up your terminal shortcuts (aliases) as described in the [Creating Terminal Shortcuts](#-creating-terminal-shortcuts-aliases) section above.**

### Scaffold a new Vite + Tailwind Project

Once your shortcuts are configured, creating a new project is simple:

```bash
qv4 my-new-app
```

That's it! The script will:
- Create a new directory called `my-new-app`
- Set up a complete React + Vite + Tailwind project structure
- Install all dependencies
- Show you the next steps

Then navigate to your project and start the dev server:

```bash
cd my-new-app
npm run dev
```

Your development server will start at `http://localhost:5173` with hot module reloading enabled.

### Generate an AI Git Commit

Making commits with AI-generated messages is just as easy:

**Step 1: Stage your changes**

```bash
git add .
# Or stage specific files
git add src/components/Button.jsx
```

**Step 2: Generate your commit**

```bash
gca
```

**Step 3: Review and confirm**

The script will display the generated commit message. Press `Enter` to confirm or `Ctrl+C` to cancel.

That's it! Your commit is created with a semantic, descriptive message.

---

## 🔧 Script Deep Dives

### How Automate Vite Build Works Under the Hood

1. **Validates input** — Checks if project name is provided and doesn't already exist
2. **Creates directory structure** — Scaffolds folders for `src/`, `public/`, and config files
3. **Generates package.json** — Dynamically creates with React, Vite, Tailwind, and PostCSS dependencies
4. **Injects vite.config.js** — Configures Vite with React plugin and Tailwind integration
5. **Creates index.html** — Entry point with React root element
6. **Generates App.jsx & index.css** — Pre-styled dark-mode starter components
7. **Runs npm install** — Silently installs all dependencies
8. **Success message** — Displays next steps for the user

### How AI Commit Generator Works Under the Hood

1. **Reads git status** — Gets list of staged and unstaged files
2. **Generates diff** — Creates a comprehensive diff of changes
3. **Filters noise** — Excludes `package-lock.json` and other non-essential files to save API tokens
4. **Streams to LLM** — Sends diff to OpenAI or Cerebras API
5. **Parses response** — Extracts the generated commit message
6. **Validates format** — Ensures message follows conventional commit standards
7. **Prompts user** — Displays message and waits for confirmation
8. **Creates commit** — Runs `git commit` with the approved message

---

## 🐛 Troubleshooting

### Error: `"Argument list too long"`
**Cause:** You are likely running an outdated version of the `.sh` commit script on a massive repository with thousands of changed files.

**Solution:**
- Pull the latest code: `git pull origin main`
- Or switch to the `.js` version which handles infinite string memory natively: `node ./automated_commit.js`

### Error: `SyntaxError: Invalid or unexpected token`
**Cause:** You accidentally tried to run a Bash script (`.sh`) using the `node` command.

**Solution:**
- Run `.sh` files directly: `./script.sh` or `bash script.sh`
- Don't use: `node script.sh` ❌

### Error: `jq: command not found`
**Cause:** You are missing the `jq` library required for the Bash AI committer.

**Solution:**
- Install jq:
  - macOS: `brew install jq`
  - Windows (Chocolatey): `choco install jq`
  - Windows (Manual): [Download from jqlang.github.io](https://jqlang.github.io/jq/download/)
- Or switch to the Node.js equivalent: `node ./automated_commit.js`

### Error: `Command not found: qv4`
**Cause:** The alias is not recognized. The shell hasn't reloaded your configuration file.

**Solution:**
- Manually reload: `source ~/.bashrc` (Bash) or `source ~/.zshrc` (Zsh)
- Or restart your terminal completely

### Error: `Permission denied` when running scripts
**Cause:** The scripts don't have executable permissions.

**Solution:**
```bash
chmod +x *.sh *.js
```

### Error: `API_KEY is undefined`
**Cause:** You forgot to add your API key to the script file.

**Solution:**
- Open `automated_commit.js` or `automated_commit.sh`
- Find the line with `const API_KEY = "sk-..."`
- Replace with your actual key from OpenAI or Cerebras

---

## 🤝 Contributing

**DevMicroScripts is entirely Open Source!** Our goal is to populate this repository with a massive, reliable library of mini-scripts that make every developer's life easier.

If you have a script that automates a tedious process (database seeding, Docker wipeout, image optimization, deployment automation, etc.), we want it here!

### Contribution Workflow

1. **Fork** the repository.
2. Create a new branch for your script:
   ```bash
   git checkout -b feature/awesome-new-script
   ```
3. Commit your changes (feel free to use the AI committer!):
   ```bash
   gca
   ```
4. Push to the branch:
   ```bash
   git push origin feature/awesome-new-script
   ```
5. Open a **Pull Request** on GitHub.

### Contribution Guidelines

Please ensure your scripts meet these standards:

- **Well-commented:** Include comments explaining what the script does and any dependencies required
- **Error handling:** Gracefully handle errors and edge cases
- **Zero-dependency fallbacks:** Where possible, provide fallback options
- **Cross-platform:** Test on Windows (Git Bash), macOS, and Linux
- **README entry:** Document your script with usage examples
- **Performance:** Scripts should complete in under 30 seconds for typical use cases

---

## 🛡️ Strict Code of Conduct

To ensure this repository remains a safe, highly trusted, and reliable toolset for developers everywhere, we enforce a strict zero-tolerance policy on malicious software.

**There shall be absolutely no adding, creation, or suggestion of malicious code that may be harmful to anyone in the community.**

This includes, but is not limited to:

* Scripts that intentionally delete, format, or corrupt data outside of their explicit, documented scope
* Scripts that obscure malicious payloads or attempt unauthorized data exfiltration (e.g., stealing `.env` files, SSH keys, or API tokens)
* Any code intended to act as malware, spyware, cryptominers, or ransomware
* Hardcoding tracking beacons into workflows
* Scripts that make unauthorized network requests or data transmissions

**Enforcement:** Any pull request violating this policy will be immediately closed, the user will be reported to GitHub Trust & Safety, and they will be permanently banned from contributing to this repository.

---

## 📝 License

This project is open-source and available under the [MIT License](https://opensource.org/licenses/MIT). Feel free to clone, modify, and customize the styling blocks and parameters to fit your unique development style guidelines.
