#!/bin/bash
# Bash script to scaffold a premium Vite + Tailwind v4 project instantly

PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
    echo "❌ Error: Please provide a project name."
    echo "Usage: ./automate_vite_build.sh <project-name>"
    exit 1
fi

TARGET_DIR="$(pwd)/$PROJECT_NAME"

echo "🚀 Scaffolding a custom Vite + Tailwind v4 project: $PROJECT_NAME..."

# 1. Create the structural directories manually
mkdir -p "$TARGET_DIR/src"
mkdir -p "$TARGET_DIR/public"

if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ Error: Failed to create directories."
    exit 1
fi

cd "$TARGET_DIR" || exit 1

# 2. Write a clean, optimal package.json file directly
cat << 'EOF' > package.json
{
  "name": "vite-tailwind-v4-app",
  "private": true,
  "version": "0.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^19.0.0",
    "react-dom": "^19.0.0"
  },
  "devDependencies": {
    "@tailwindcss/vite": "^4.0.0",
    "@vitejs/plugin-react": "^4.3.4",
    "tailwindcss": "^4.0.0",
    "vite": "^6.0.0"
  }
}
EOF

# 3. Write index.html to the project root
cat << EOF > index.html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>$PROJECT_NAME</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>
EOF

# 4. Write src/main.jsx
cat << 'EOF' > src/main.jsx
import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import './index.css'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <App />
  </StrictMode>,
)
EOF

# 5. Configure vite.config.js with the Tailwind v4 plugin
cat << 'EOF' > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [
    react(),
    tailwindcss(),
  ],
})
EOF

# 6. Inject Tailwind v4's unified import directive into src/index.css
cat << 'EOF' > src/index.css
@import "tailwindcss";

body {
  @apply bg-zinc-950 text-zinc-50 antialiased;
}
EOF

# 7. Write src/App.jsx with your minimalist starter UI
cat << 'EOF' > src/App.jsx
import React from 'react';

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
          Your sleek developer workspace is running on the ultra-fast Rust-powered engine. Scaffolding built natively via Shell.
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

export default App;
EOF
# Create the .gitignore file
cat << EOF > .gitignore
# dependencies
node_modules
.pnp
.pnp.js

# testing
coverage

# production
dist

# misc
.DS_Store
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

npm-debug.log*
yarn-debug.log*
yarn-error.log*
EOF


# 8. Run npm install down at the very end
echo "📦 Installing core & dev dependencies via npm..."
if ! npm install; then
    echo "❌ Failed executing npm install"
    exit 1
fi

echo -e "\n🔥 Setup Complete!"
echo "----------------------------------------------"
echo "📦 Project folder created: $PROJECT_NAME"
echo "🎨 Tailwind CSS v4 configured via Vite plugin"
echo "⚡ Minimalist premium UI applied successfully"
echo "----------------------------------------------"

echo -e "\nTo launch your new development server, run:\n"
echo "  cd $PROJECT_NAME"
echo -e "  npm run dev\n"
