
# -DevMicroScripts

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Open Source](https://img.shields.io/badge/Open%20Source-%E2%9D%A4-red)]()

A growing, open-source library of zero-dependency micro-scripts for the terminal tasks you hate doing twice.

Instead of manual commands or tedious setup wizards, these scripts handle the heavy lifting instantly. We are starting with instant Vite scaffolding and AI-powered Git commits, but this is just the beginning.

We are actively looking for community contributions to expand this collection into the ultimate developer toolkit.


**✨ Note: This is an actively growing open-source repository! More time-saving scripts are constantly being added.**

---

## 📑 Table of Contents
1. [Available Scripts](#-available-scripts)
2. [Global Prerequisites](#️-global-prerequisites)
3. [Installation & Setup](#-installation--setup)
4. [Usage Guide](#-usage-guide)
5. [Creating Terminal Shortcuts](#-creating-terminal-shortcuts-aliases)
6. [Troubleshooting](#-troubleshooting)
7. [Contributing](#-contributing)
8. [Code of Conduct](#️-strict-code-of-conduct)
9. [License](#-license)

---

## 🚀 Available Scripts

### 1. Automated Vite + Tailwind v4 Bootstrapper
Bypasses the sluggish, interactive `npm create` CLI prompts by programmatically scaffolding folders. 
* **Available in:** `Node.js` & `Bash`
* **Features:**
  * Instantly builds a standard React + Vite directory structure.
  * Autogenerates an optimized `package.json` with the latest dependencies.
  * Injects `vite.config.js` with the official Tailwind v4 plugin.
  * Applies premium minimalist dark-mode global styles out of the box.
  * Runs a silent `npm install` to finish the setup automatically.

### 2. AI-Powered Conventional Commits
Streams your repository's structural diff changes directly into an ultra-fast LLM engine to generate precise, semantic git commits.
* **Available in:** `Node.js` & `Bash`
* **Features:**
  * **Token Defense Layer:** Programmatically ignores heavy `package-lock.json` modifications to preserve API bandwidth and lower costs.
  * **Zero-Dependency (Node):** Runs natively without needing `node_modules` or `.env` files.
  * **Buffer Immune (Bash):** Uses physical temporary file streams to bypass the Windows `Argument list too long` terminal limits.

---

## 🛠️ Global Prerequisites

Before launching the scripts, ensure your workspace has the following global tools installed:

1. **[Node.js](https://nodejs.org/)**: Version `v20.0.0` or higher (Required for the `.js` scripts).
2. **[Git / Git Bash](https://gitforwindows.org/)**: Recommended for Windows developers to run `.sh` natively.
3. **[jq](https://jqlang.github.io/jq/)**: A lightweight command-line JSON processor (Required **only** for the `.sh` AI commit script).

---

## 📦 Installation & Setup

Follow these exact steps to clone the scripts to a permanent home on your machine and make them executable.

### Step 1: Clone the Repository
Choose a central directory on your computer (we recommend `~/Documents`) to store your automation suite:

```bash
cd ~/Documents
git clone [https://github.com/YOUR_GITHUB_USERNAME/DevMicroScripts.git](https://github.com/YOUR_GITHUB_USERNAME/DevMicroScripts.git)
cd DevMicroScripts

```

### Step 2: Configure Executable Permissions

If you are operating on Linux, macOS, or using Git Bash on Windows, grant absolute system permissions to make the scripts executable directly from the terminal:

```bash
chmod +x automated_commit.sh || automated_commit.js
chmod +x automate_vite_build.sh || automate_vite_build.js

```

### Step 3: Add Your API Key (For AI Commits)

If you are using the AI Automated Commit scripts, open the file (`automated_commit.js` or `automated_commit.sh`) in your code editor and replace the placeholder `API_KEY` string with your actual Cerebras/OpenAI key.

---

## 🕹️ Usage Guide

### Scaffold a new Vite Project

Navigate to your parent development folder and call the script, passing your desired project folder name as the argument.

**Using the Node.js Engine:**

```bash
node ~/Documents/DevMicroScripts/automate_vite_build.js my-new-app

```

**Using the Bash Engine:**

```bash
~/Documents/DevMicroScripts/automate_vite_build.sh my-new-app

```

Once complete, simply `cd my-new-app` and run `npm run dev`.

### Generate an AI Git Commit

Stage your layout modifications (optional, the script will auto-stage if empty) and execute the script.

**Using the Node.js Engine:**

```bash
node ~/Documents/DevMicroScripts/automated_commit.js

```

**Using the Bash Engine:**

```bash
~/Documents/DevMicroScripts/automated_commit.sh

```

---

## 🏎️ Creating Terminal Shortcuts (Aliases)

To skip typing out the long absolute file paths every single time, you can create brief terminal command shortcuts inside your shell configuration profile.

### For Git Bash / Linux (`.bashrc`):

1. Open your configuration file:
```bash
notepad ~/.bashrc

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



Now you can build an entire workspace with just `qv4 my-project` or commit your code with `gca` from anywhere on your machine!

---

## 🐛 Troubleshooting

* **`"Argument list too long"` Error:** You are likely running an outdated version of the `.sh` commit script on a massive repo. Pull the latest code, or switch to the `.js` version which handles infinite string memory natively.
* **`SyntaxError: Invalid or unexpected token`:** You accidentally tried to run a Bash script (`.sh`) using the `node` command. Run `.sh` files directly (e.g., `./script.sh`).
* **`jq: command not found`:** You are missing the `jq` library required for the Bash AI committer. Download it or switch to the Node.js equivalent.

---

## 🤝 Contributing

**DevMicroScripts is entirely Open Source!** Our goal is to populate this repository with a massive, reliable library of mini-scripts that make every developer's life easier.

If you have a script that automates a tedious process (database seeding, docker wipeout, image optimization, etc.), we want it here!

1. **Fork** the repository.
2. Create a new branch for your script (`git checkout -b feature/awesome-new-script`).
3. Commit your changes (feel free to use the AI committer!).
4. Push to the branch (`git push origin feature/awesome-new-script`).
5. Open a **Pull Request**.

Please ensure your scripts are well-commented and include both error handling and zero-dependency fallbacks where possible.

---

## 🛡️ Strict Code of Conduct

To ensure this repository remains a safe, highly trusted, and reliable toolset for developers everywhere, we enforce a strict zero-tolerance policy on malicious software.

**There shall be absolutely no adding, creation, or suggestion of malicious code that may be harmful to anyone in the community.**

This includes, but is not limited to:

* Scripts that intentionally delete, format, or corrupt data outside of their explicit, documented scope.
* Scripts that obscure malicious payloads or attempt unauthorized data exfiltration (e.g., stealing `.env` files, SSH keys, or API tokens).
* Any code intended to act as malware, spyware, cryptominers, or ransomware.
* Hardcoding tracking beacons into workflows.

**Enforcement:** Any pull request violating this policy will be immediately closed, the user will be reported to GitHub Trust & Safety, and they will be permanently banned from contributing to this repository.

---

## 📝 License

This project is open-source and available under the [MIT License](https://www.google.com/search?q=LICENSE). Feel free to clone, modify, and customize the styling blocks and parameters to fit your unique development style guidelines.
