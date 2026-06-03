#!/usr/bin/env node

import { execSync } from 'child_process';
import fs from 'fs';
import path from 'path';

const projectName = process.argv[2];

if (!projectName) {
  console.error("❌ Error: Please provide a project name.");
  console.log("Usage: node automate_vite_build.js <project-name>");
  process.exit(1);
}

const targetDir = path.join(process.cwd(), projectName);

const runCommand = (cmd) => {
  try {
    execSync(cmd, { stdio: 'inherit' });
    return true;
  } catch (error) {
    console.error(`❌ Failed executing: ${cmd}`);
    return false;
  }
};

async function bootstrap() {
  console.log(`🚀 Scaffolding a custom Vite + Tailwind v4 project: ${projectName}...`);

  // 1. Create the structural directories manually
  try {
    fs.mkdirSync(targetDir, { recursive: true });
    fs.mkdirSync(path.join(targetDir, 'src'), { recursive: true });
    fs.mkdirSync(path.join(targetDir, 'public'), { recursive: true });
  } catch (err) {
    console.error("❌ Error: Failed to create directories.");
    process.exit(1);
  }

  process.chdir(targetDir);

  // 2. Write a clean, optimal package.json file directly
  const packageJsonContent = {
    name: projectName,
    private: true,
    version: "0.0.0",
    type: "module",
    scripts: {
      dev: "vite",
      build: "vite build",
      preview: "vite preview"
    },
    dependencies: {
      react: "^19.0.0",
      "react-dom": "^19.0.0"
    },
    devDependencies: {
      "@tailwindcss/vite": "^4.0.0",
      "@vitejs/plugin-react": "^4.3.4",
      tailwindcss: "^4.0.0",
      vite: "^6.0.0"
    }
  };
  fs.writeFileSync(path.join(targetDir, 'package.json'), JSON.stringify(packageJsonContent, null, 2));

  // 3. Write index.html to root
  const htmlContent = `<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${projectName}</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>`;
  fs.writeFileSync(path.join(targetDir, 'index.html'), htmlContent);

  // 4. Write src/main.jsx
  const mainJsxContent = `
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import './index.css'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
)`;
  fs.writeFileSync(path.join(targetDir, 'src/main.jsx'), mainJsxContent);

  // 5. Configure vite.config.js with Tailwind v4 plugin
  const viteConfigContent = `import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
})`
  fs.writeFileSync(path.join(targetDir, 'vite.config.js'), viteConfigContent);

  // 6. Inject Tailwind v4's unified import directive into src/index.css
  const tailwindDirectives = `@import "tailwindcss";

body {
  @apply bg-zinc-950 text-zinc-50 antialiased;
}`;
  fs.writeFileSync(path.join(targetDir, 'src/index.css'), tailwindDirectives);

  // 7. Overwrite src/App.jsx with your minimalist starter UI
  const minimalAppContent = `import React from 'react';

function App() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center p-6 text-center">
      <header className="max-w-md space-y-4">
        <div className="mx-auto w-16 h-16 rounded-2xl bg-gradient-to-tr from-cyan-500 to-indigo-500 flex items-center justify-center text-2xl shadow-xl shadow-indigo-500/20">
          ⚡
        </div>
        <h1 className="text-3xl font-bold tracking-tight sm:text-4xl">
          Vite + Tailwind v4
        </h1>
        <p className="text-zinc-400 text-sm">
          Your sleek developer workspace is running on the ultra-fast Rust-powered engine. No broken prompts, no hassle!
        </p>
        <div className="pt-2">
          <code className="px-3 py-1.5 rounded-lg bg-zinc-900 border border-zinc-800 text-xs font-mono text-cyan-400">
            src/App.jsx
          </code>
        </div>
      </header>
    </div>
  );
}

export default App;`;
  fs.writeFileSync(path.join(targetDir, 'src/App.jsx'), minimalAppContent);

  // 8. Run npm install down at the very end
  console.log("📦 Installing core & dev dependencies via npm...");
  const installed = runCommand("npm install");
  if (!installed) process.exit(1);

  console.log("\n🔥 Setup Complete!");
  console.log("----------------------------------------------");
  console.log(`📦 Project folder created: ${projectName}`);
  console.log("🎨 Tailwind CSS v4 configured via Vite plugin");
  console.log("⚡ Minimalist premium UI applied successfully");
  console.log("----------------------------------------------");
  
  console.log(`\nTo launch your new development server, run:\n`);
  console.log(`  cd ${projectName}`);
  console.log(`  npm run dev\n`);
}

bootstrap();