#!/bin/bash
# merge-and-cleanup.sh - Consolidate plugin-marketplace structure
# This script merges duplicate content and cleans up redundancies

set -e

REPO_DIR="/Users/omh/bin/development/claude-code/plugin-marketplace"
cd "$REPO_DIR"

echo "═══════════════════════════════════════════════════════════"
echo "  Plugin Marketplace Merge & Cleanup"
echo "═══════════════════════════════════════════════════════════"
echo ""

# ─────────────────────────────────────────────────────────────────
# Step 1: Merge moodle-dev-pro (ROOT → plugins/)
# ─────────────────────────────────────────────────────────────────
echo "→ Step 1: Merging moodle-dev-pro..."

# Copy agents from root to plugins/
if [ -d "moodle-dev-pro/agents" ]; then
    echo "  Copying agents..."
    cp -r moodle-dev-pro/agents/* plugins/moodle-dev-pro/agents/ 2>/dev/null || true
fi

# Copy commands from root to plugins/
if [ -d "moodle-dev-pro/commands" ]; then
    echo "  Copying commands..."
    cp -r moodle-dev-pro/commands/* plugins/moodle-dev-pro/commands/ 2>/dev/null || true
fi

# Copy hooks from root to plugins/
if [ -d "moodle-dev-pro/hooks" ]; then
    echo "  Copying hooks..."
    mkdir -p plugins/moodle-dev-pro/hooks
    cp -r moodle-dev-pro/hooks/* plugins/moodle-dev-pro/hooks/ 2>/dev/null || true
fi

# Copy detailed skills (psr12-moodle, wcag-validator) from root
if [ -d "moodle-dev-pro/skills/psr12-moodle" ]; then
    echo "  Copying psr12-moodle skill..."
    cp -r moodle-dev-pro/skills/psr12-moodle plugins/moodle-dev-pro/skills/
fi

if [ -d "moodle-dev-pro/skills/wcag-validator" ]; then
    echo "  Copying wcag-validator skill..."
    cp -r moodle-dev-pro/skills/wcag-validator plugins/moodle-dev-pro/skills/
fi

# Copy README
if [ -f "moodle-dev-pro/README.md" ]; then
    echo "  Copying README..."
    cp moodle-dev-pro/README.md plugins/moodle-dev-pro/
fi

echo "  ✓ moodle-dev-pro merged"

# ─────────────────────────────────────────────────────────────────
# Step 2: Move server-ops to plugins/
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Step 2: Moving server-ops to plugins/..."

if [ -d "server-ops" ] && [ ! -d "plugins/server-ops" ]; then
    cp -r server-ops plugins/
    echo "  ✓ server-ops moved to plugins/"
else
    echo "  ⚠ server-ops already exists in plugins/ or not found"
fi

# ─────────────────────────────────────────────────────────────────
# Step 3: Move plugin-forge to plugins/
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Step 3: Moving plugin-forge to plugins/..."

if [ -d "plugin-forge" ] && [ ! -d "plugins/plugin-forge" ]; then
    cp -r plugin-forge plugins/
    echo "  ✓ plugin-forge moved to plugins/"
else
    echo "  ⚠ plugin-forge already exists in plugins/ or not found"
fi

# ─────────────────────────────────────────────────────────────────
# Step 4: Copy base files from claude-code-remote
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Step 4: Updating base/ with latest config..."

REMOTE_DIR="/Users/omh/bin/development/claude-code/claude-code-remote"

if [ -d "$REMOTE_DIR/base" ]; then
    # Copy .mcp.json if exists
    if [ -f "$REMOTE_DIR/base/.mcp.json" ]; then
        cp "$REMOTE_DIR/base/.mcp.json" base/
        echo "  ✓ Copied .mcp.json (Chrome DevTools, Context7, Serena)"
    fi

    # Copy settings.json if exists
    if [ -f "$REMOTE_DIR/base/settings.json" ]; then
        cp "$REMOTE_DIR/base/settings.json" base/
        echo "  ✓ Copied settings.json (5 marketplaces)"
    fi

    # Copy setup script
    if [ -f "$REMOTE_DIR/setup-claude.sh" ]; then
        cp "$REMOTE_DIR/setup-claude.sh" ./
        echo "  ✓ Copied setup-claude.sh"
    fi
fi

# ─────────────────────────────────────────────────────────────────
# Step 5: Update marketplace.json with all plugins
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Step 5: Updating marketplace.json..."

cat > marketplace.json << 'EOF'
{
  "$schema": "https://schemas.claude.ai/marketplace/v1/schema.json",
  "name": "astoeffer-dev-plugins",
  "description": "Development plugins for Moodle, AI applications, and GPU cluster development",
  "author": "Andreas Stöffer",
  "repository": "https://github.com/astoeffer/plugin-marketplace",
  "baseMcpServers": {
    "chrome-devtools": {
      "command": "npx",
      "args": ["-y", "@anthropic/chrome-devtools-mcp"],
      "description": "Chrome DevTools debugging - DOM, network, console, performance, accessibility"
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"],
      "env": {
        "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
      },
      "description": "Library documentation lookup"
    },
    "serena": {
      "command": "uvx",
      "args": ["--from", "git+https://github.com/oraios/serena", "serena", "start-mcp-server", "--context", "ide-assistant"],
      "description": "Semantic code analysis and project memory"
    }
  },
  "plugins": [
    {
      "name": "moodle-dev-pro",
      "version": "2.0.0",
      "description": "Comprehensive Moodle plugin development with PSR-12, accessibility, AI subsystem, Docker multi-version support",
      "path": "plugins/moodle-dev-pro",
      "keywords": ["moodle", "php", "lms", "accessibility", "ai", "psr-12", "wcag"],
      "contexts": ["moodle-core", "moodle-ai", "accessibility"],
      "agents": ["moodle-architect", "docker-ops", "moodle-a11y"],
      "commands": ["implement", "troubleshoot", "git", "task", "test"],
      "skills": ["psr12-moodle", "wcag-validator", "moodle-standards", "accessibility-audit", "moodle-ai-integration"]
    },
    {
      "name": "ai-app-dev",
      "version": "1.0.0",
      "description": "AI application development with PocketFlow, LLM integration, and agent patterns",
      "path": "plugins/ai-app-dev",
      "keywords": ["ai", "llm", "agents", "pocketflow", "python", "chatbot", "gpu"],
      "contexts": ["pocketflow", "frontend", "dgx-h100"],
      "skills": ["pocketflow-patterns", "chatbot-integration"]
    },
    {
      "name": "moodle-admin",
      "version": "1.0.0",
      "description": "Moodle administration, webservices, reporting, and analytics",
      "path": "plugins/moodle-admin",
      "keywords": ["moodle", "admin", "webservices", "reporting", "analytics"],
      "contexts": ["moodle-core", "moodle-admin"],
      "skills": ["webservice-patterns", "reporting-analytics"]
    },
    {
      "name": "server-ops",
      "version": "1.0.0",
      "description": "Server administration, Docker automation, monitoring for Moodle environments",
      "path": "plugins/server-ops",
      "keywords": ["server", "docker", "monitoring", "devops", "moodle"],
      "agents": ["server-admin"],
      "commands": ["logs", "monitor", "moodle-cache"],
      "skills": ["defensive-bash"]
    },
    {
      "name": "plugin-forge",
      "version": "1.0.0",
      "description": "Meta-plugin for creating, validating, and testing Claude Code plugins",
      "path": "plugins/plugin-forge",
      "keywords": ["plugin", "scaffolding", "validation", "development"],
      "agents": ["plugin-architect"],
      "commands": ["plugin-new", "plugin-validate"]
    }
  ],
  "contexts": {
    "moodle-core": {
      "description": "Moodle coding standards (PSR-12 with exceptions), Frankenstyle, Core APIs",
      "path": "contexts/moodle-core.md",
      "tokens": 1200
    },
    "moodle-ai": {
      "description": "Moodle AI Subsystem (4.5+): Actions, Providers, Placements",
      "path": "contexts/moodle-ai.md",
      "tokens": 1000
    },
    "moodle-admin": {
      "description": "Webservices, reporting, scheduled tasks",
      "path": "contexts/moodle-admin.md",
      "tokens": 800
    },
    "pocketflow": {
      "description": "PocketFlow LLM framework: Nodes, Flows, Agent patterns",
      "path": "contexts/pocketflow.md",
      "tokens": 1000
    },
    "accessibility": {
      "description": "EU accessibility (EN 301 549, WCAG 2.1 AA)",
      "path": "contexts/accessibility.md",
      "tokens": 800
    },
    "frontend": {
      "description": "Chatbot widgets, iframe integration, UI patterns",
      "path": "contexts/frontend.md",
      "tokens": 600
    },
    "dgx-h100": {
      "description": "DGX H100 GPU cluster, SLURM, Docker patterns",
      "path": "contexts/dgx-h100.md",
      "tokens": 1200
    }
  },
  "projectTemplates": [
    {
      "name": "moodle-plugin",
      "description": "Standard Moodle plugin with PSR-12 and accessibility",
      "path": "project-templates/moodle-plugin"
    },
    {
      "name": "moodle-ai-plugin",
      "description": "Moodle plugin with AI Subsystem integration (4.5+)",
      "path": "project-templates/moodle-ai-plugin"
    },
    {
      "name": "pocketflow-chatbot",
      "description": "PocketFlow chatbot with Moodle integration",
      "path": "project-templates/pocketflow-chatbot"
    },
    {
      "name": "moodle-admin-tool",
      "description": "Moodle admin tool with webservices and reporting",
      "path": "project-templates/moodle-admin-tool"
    },
    {
      "name": "dgx-h100-app",
      "description": "GPU-accelerated AI application for DGX H100",
      "path": "project-templates/dgx-h100-app"
    }
  ]
}
EOF

echo "  ✓ marketplace.json updated"

# ─────────────────────────────────────────────────────────────────
# Step 6: Remove redundant files/directories
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Step 6: Removing redundant files..."

# Remove root-level CLAUDE.md (keep base/CLAUDE.md)
if [ -f "CLAUDE.md" ]; then
    rm "CLAUDE.md"
    echo "  ✓ Removed root CLAUDE.md (using base/CLAUDE.md)"
fi

# Remove old .claude-plugin directory
if [ -d ".claude-plugin" ]; then
    rm -rf ".claude-plugin"
    echo "  ✓ Removed .claude-plugin/ (old format)"
fi

# Remove root-level moodle-dev-pro (now merged into plugins/)
if [ -d "moodle-dev-pro" ]; then
    rm -rf "moodle-dev-pro"
    echo "  ✓ Removed root moodle-dev-pro/ (merged into plugins/)"
fi

# Remove root-level server-ops (now in plugins/)
if [ -d "server-ops" ]; then
    rm -rf "server-ops"
    echo "  ✓ Removed root server-ops/ (moved to plugins/)"
fi

# Remove root-level plugin-forge (now in plugins/)
if [ -d "plugin-forge" ]; then
    rm -rf "plugin-forge"
    echo "  ✓ Removed root plugin-forge/ (moved to plugins/)"
fi

# Remove claude-plugin-toolkit (merged into plugin-forge)
if [ -d "claude-plugin-toolkit" ]; then
    # First merge any unique content
    if [ -d "claude-plugin-toolkit/skills" ] && [ -d "plugins/plugin-forge" ]; then
        mkdir -p plugins/plugin-forge/skills
        cp -r claude-plugin-toolkit/skills/* plugins/plugin-forge/skills/ 2>/dev/null || true
    fi
    if [ -d "claude-plugin-toolkit/references" ] && [ -d "plugins/plugin-forge" ]; then
        mkdir -p plugins/plugin-forge/references
        cp -r claude-plugin-toolkit/references/* plugins/plugin-forge/references/ 2>/dev/null || true
    fi
    rm -rf "claude-plugin-toolkit"
    echo "  ✓ Removed claude-plugin-toolkit/ (merged into plugin-forge)"
fi

# Remove git-push.sh helper if exists
if [ -f "git-push.sh" ]; then
    rm "git-push.sh"
    echo "  ✓ Removed git-push.sh"
fi

# ─────────────────────────────────────────────────────────────────
# Step 7: Update README
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Step 7: Updating README..."

if [ -f "/Users/omh/bin/development/claude-code/claude-code-remote/README.md" ]; then
    cp "/Users/omh/bin/development/claude-code/claude-code-remote/README.md" ./README.md
    echo "  ✓ README updated"
fi

# ─────────────────────────────────────────────────────────────────
# Summary
# ─────────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  Merge Complete!"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "New Structure:"
echo ""
find plugins -type d -maxdepth 2 | sort
echo ""
echo "Files removed:"
echo "  • CLAUDE.md (root)"
echo "  • .claude-plugin/"
echo "  • moodle-dev-pro/ (root)"
echo "  • server-ops/ (root)"
echo "  • plugin-forge/ (root)"
echo "  • claude-plugin-toolkit/"
echo ""
echo "Next steps:"
echo "  git add -A"
echo "  git status"
echo "  git commit -m 'Consolidate plugins, remove redundancies'"
echo "  git push"
echo ""
