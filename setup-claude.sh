#!/bin/bash
# setup-claude.sh - Unified Claude Code Setup for Hetzner Servers
# Run this on each new server

set -e

echo "═══════════════════════════════════════════════════════════"
echo "  Claude Code Unified Setup"
echo "═══════════════════════════════════════════════════════════"

# ─────────────────────────────────────────────────────────────────
# Layer 1: SuperClaude Base (optional, if using SuperClaude)
# ─────────────────────────────────────────────────────────────────
if command -v pipx &> /dev/null; then
    echo ""
    echo "→ Installing SuperClaude base..."
    pipx install superclaude 2>/dev/null || echo "  SuperClaude already installed or not available"
    superclaude install 2>/dev/null || true
fi

# ─────────────────────────────────────────────────────────────────
# Layer 2: Clone/Update Marketplace Repository
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Setting up plugin marketplace..."

MARKETPLACE_DIR="$HOME/.claude-marketplace"

if [ -d "$MARKETPLACE_DIR" ]; then
    echo "  Updating existing marketplace..."
    cd "$MARKETPLACE_DIR" && git pull
else
    echo "  Cloning marketplace..."
    git clone https://github.com/astoeffer/plugin-marketplace "$MARKETPLACE_DIR"
fi

# ─────────────────────────────────────────────────────────────────
# Layer 3: Copy Configuration Files
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Installing configuration files..."

mkdir -p ~/.claude

# Copy base CLAUDE.md
cp "$MARKETPLACE_DIR/base/CLAUDE.md" ~/.claude/CLAUDE.md
echo "  ✓ CLAUDE.md installed"

# Copy MCP configuration
cp "$MARKETPLACE_DIR/base/.mcp.json" ~/.claude/.mcp.json
echo "  ✓ .mcp.json installed (Chrome DevTools, Context7, Serena)"

# Copy settings with marketplaces
cp "$MARKETPLACE_DIR/base/settings.json" ~/.claude/settings.json
echo "  ✓ settings.json installed (5 marketplaces configured)"

# Copy context modules
cp -r "$MARKETPLACE_DIR/contexts" ~/.claude/contexts
echo "  ✓ Context modules installed (7 modules)"

# ─────────────────────────────────────────────────────────────────
# Layer 4: Environment Variables
# ─────────────────────────────────────────────────────────────────
echo ""
echo "→ Checking environment variables..."

ENV_FILE="$HOME/.claude/env.sh"

if [ ! -f "$ENV_FILE" ]; then
    cat > "$ENV_FILE" << 'EOF'
# Claude Code MCP API Keys
# Add your keys here and source this file in .bashrc/.zshrc

export CONTEXT7_API_KEY="your-context7-key-here"
export TAVILY_API_KEY="your-tavily-key-here"

# Optional: Default model
# export ANTHROPIC_MODEL="sonnet"
EOF
    echo "  ✓ Created $ENV_FILE (add your API keys!)"
else
    echo "  ✓ $ENV_FILE already exists"
fi

# ─────────────────────────────────────────────────────────────────
# Verification
# ─────────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  Setup Complete!"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "Installed:"
echo "  • CLAUDE.md (base configuration)"
echo "  • .mcp.json (Chrome DevTools, Context7, Serena)"
echo "  • settings.json (5 marketplaces)"
echo "  • 7 context modules"
echo ""
echo "Marketplaces configured:"
echo "  • anthropics-claude-code (official)"
echo "  • anthropics-skills (document processing)"
echo "  • wshobson-agents (66 plugins, 87 agents)"
echo "  • diegocconsolini-claudeskillcollection (security, GDPR)"
echo "  • astoeffer-plugins (Moodle development)"
echo ""
echo "Next steps:"
echo ""
echo "  1. Add API keys to ~/.claude/env.sh:"
echo "     export CONTEXT7_API_KEY=\"ctx7sk-...\""
echo "     export TAVILY_API_KEY=\"tvly-dev-...\""
echo ""
echo "  2. Source env file (add to .bashrc/.zshrc):"
echo "     source ~/.claude/env.sh"
echo ""
echo "  3. Install plugins in Claude Code:"
echo "     /plugin install moodle-dev-pro@astoeffer-plugins"
echo "     /plugin install pdf-smart-extractor@diegocconsolini-claudeskillcollection"
echo "     /plugin install debugging-toolkit@wshobson-agents"
echo ""
echo "  4. For Moodle projects, copy a template:"
echo "     cp -r ~/.claude-marketplace/project-templates/moodle-plugin/.claude ."
echo ""
