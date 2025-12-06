# Claude Code Modular Configuration Framework

Token-efficient, context-specific configuration for learning developers.

## Architecture

```
~/.claude/
├── CLAUDE.md              ← BASE (minimal, ~30 lines)
├── .mcp.json              ← MCP SERVERS (Chrome DevTools, Context7, Serena)
├── settings.json          ← MARKETPLACES (5 configured)
├── env.sh                 ← API KEYS (user-specific)
├── contexts/              ← DOMAIN MODULES (load as needed)
│   ├── moodle-core.md        Moodle coding standards
│   ├── moodle-ai.md          Moodle AI subsystem (4.5+)
│   ├── moodle-admin.md       Webservices, reporting
│   ├── pocketflow.md         AI agent development
│   ├── accessibility.md      EU accessibility (EN 301 549)
│   ├── frontend.md           UI/chatbot patterns
│   └── dgx-h100.md           DGX H100 GPU cluster
├── plugins/               ← CLAUDE CODE PLUGINS (skills + MCPs)
│   ├── moodle-dev-pro/       Moodle plugin development
│   ├── ai-app-dev/           AI application development
│   └── moodle-admin/         Admin & webservices
└── project-templates/     ← COPY FOR NEW PROJECTS
    ├── moodle-plugin/
    ├── moodle-ai-plugin/
    ├── pocketflow-chatbot/
    ├── moodle-admin-tool/
    └── dgx-h100-app/
```

## Quick Start (Automated)

**One-line install on any server:**
```bash
curl -sSL https://raw.githubusercontent.com/astoeffer/plugin-marketplace/master/setup-claude.sh | bash
```

Or manually:
```bash
git clone https://github.com/astoeffer/plugin-marketplace ~/.claude-marketplace
~/.claude-marketplace/setup-claude.sh
```

## Quick Start (Manual)

### 1. Install Base Configuration
```bash
# Copy all base files
cp base/CLAUDE.md ~/.claude/CLAUDE.md
cp base/.mcp.json ~/.claude/.mcp.json
cp base/settings.json ~/.claude/settings.json

# Copy context modules
cp -r contexts ~/.claude/contexts
```

### 2. Configure for Project Type

**Moodle Plugin:**
```markdown
# In ~/.claude/CLAUDE.md, uncomment:
@contexts/moodle-core.md
@contexts/accessibility.md
```

**AI Chatbot:**
```markdown
@contexts/pocketflow.md
@contexts/frontend.md
@contexts/accessibility.md
```

**Moodle AI Plugin:**
```markdown
@contexts/moodle-core.md
@contexts/moodle-ai.md
@contexts/accessibility.md
```

**DGX H100 AI Application:**
```markdown
@contexts/pocketflow.md
@contexts/dgx-h100.md
@contexts/accessibility.md
```

### 3. Install Plugins
```bash
# In Claude Code:
/plugin install moodle-dev-pro@astoeffer
/plugin install ai-app-dev@astoeffer
/plugin install moodle-admin@astoeffer
```

### 4. Copy Base MCP Configuration
```bash
# Copy base .mcp.json for Chrome DevTools and core MCPs
cp base/.mcp.json ~/.claude/.mcp.json
```

### 5. Configure MCP API Keys
```bash
# Set environment variables for MCP servers
export CONTEXT7_API_KEY="ctx7sk-..."
export TAVILY_API_KEY="tvly-dev-..."
```

## Token Efficiency

| Configuration | Tokens (est.) |
|--------------|---------------|
| Full CLAUDE.md | ~8,000 |
| Base only | ~500 |
| Base + 1 context | ~1,500 |
| Base + 2 contexts | ~2,500 |

**Savings**: 60-90% token reduction with modular approach.

## Context Modules

| Module | Content | Use When |
|--------|---------|----------|
| `moodle-core.md` | PSR-12, Frankenstyle, APIs | Any Moodle plugin |
| `moodle-ai.md` | AI subsystem, Providers | AI features (4.5+) |
| `moodle-admin.md` | Webservices, reporting | Admin tools |
| `pocketflow.md` | Node/Flow patterns | AI agents |
| `accessibility.md` | WCAG, EN 301 549 | All UI work |
| `frontend.md` | Chatbot, widgets | Frontend/UI |
| `dgx-h100.md` | SLURM, Docker, GPUs | GPU cluster work |

## Plugins

### moodle-dev-pro
- **Skills**: moodle-standards, accessibility-audit, moodle-ai-integration
- **MCPs**: Context7, Serena
- **For**: Moodle plugin development

### ai-app-dev
- **Skills**: pocketflow-patterns, chatbot-integration
- **MCPs**: Context7, Tavily, Serena
- **For**: AI application development (including DGX H100)

### moodle-admin
- **Skills**: webservice-patterns, reporting-analytics
- **MCPs**: Context7, Serena
- **For**: Moodle admin tools

## Project Templates

Copy to start new projects:
```bash
# Moodle plugin
cp -r project-templates/moodle-plugin/.claude /path/to/new-project/

# AI app on DGX H100
cp -r project-templates/dgx-h100-app/.claude /path/to/new-project/
```

## Usage Flow

```
1. Start project
   └── Copy appropriate template to .claude/CLAUDE.md

2. Claude Code loads
   └── Base CLAUDE.md → @imports active contexts

3. Work on task
   └── Plugin skills provide domain guidance
   └── MCP servers enhance capabilities

4. As you grow
   └── Modify contexts, add/remove @imports
```

## For Marketplaces

To add plugins to your marketplace:
```bash
# Copy entire directory structure to marketplace repo
cp -r plugins contexts project-templates marketplace.json /path/to/astoeffer/plugin-marketplace/

# The marketplace.json contains full plugin registry
```

## MCP Server Configuration

### Base MCP Servers (always available)

| MCP Server | Purpose | Source |
|------------|---------|--------|
| Chrome DevTools | Browser debugging, DOM, network, console, accessibility | `base/.mcp.json` |
| Context7 | Library documentation lookup | `base/.mcp.json` |
| Serena | Semantic code analysis, project memory | `base/.mcp.json` |

### Plugin MCP Servers (per plugin)

| MCP Server | Purpose | Plugins |
|------------|---------|---------|
| Context7 | Library documentation | All |
| Tavily | Web search/research | ai-app-dev |
| Serena | Semantic code analysis | All |

### Chrome DevTools Capabilities

When Chrome is running in debug mode (`--remote-debugging-port=9222`):
- **DOM Inspection**: Query and modify page elements
- **Network Analysis**: Monitor requests, responses, timing
- **Console**: Execute JavaScript, view logs
- **Performance**: CPU/memory profiling, runtime metrics
- **Accessibility**: Audit WCAG compliance, ARIA attributes

## Token Budget Strategy

| Context | Budget |
|---------|--------|
| Base | 500 |
| Per module | 800-1,200 |
| Skills (on demand) | 500-800 |
| **Max recommended** | 5,000 |

Keep total context under 5K tokens for efficient operation.

## Remote Development (Hetzner/VS Code)

For centralized configuration across multiple remote servers:

**One-line setup:**
```bash
curl -sSL https://raw.githubusercontent.com/astoeffer/plugin-marketplace/master/setup-claude.sh | bash
```

Then add your API keys to `~/.claude/env.sh` and source it.

## Configured Marketplaces

The `settings.json` includes 5 marketplaces:

| Marketplace | Repository | Purpose |
|-------------|------------|---------|
| anthropics-claude-code | anthropics/claude-code | Official: PR review, commits, security |
| anthropics-skills | anthropics/skills | Document processing (PDF, XLSX, DOCX) |
| wshobson-agents | wshobson/agents | 66 plugins, 87 agents, full dev lifecycle |
| diegocconsolini-claudeskillcollection | diegocconsolini/ClaudeSkillCollection | Security, GDPR, smart extractors |
| astoeffer-plugins | astoeffer/plugin-marketplace | Moodle development tools |

### Recommended Plugins for Learning Developers

```bash
# Document handling (token-efficient extractors)
/plugin install pdf-smart-extractor@diegocconsolini-claudeskillcollection
/plugin install xlsx-smart-extractor@diegocconsolini-claudeskillcollection

# Security & compliance
/plugin install security-guidance@anthropics-claude-code
/plugin install gdpr-auditor@diegocconsolini-claudeskillcollection

# Development workflow
/plugin install debugging-toolkit@wshobson-agents
/plugin install git-pr-workflows@wshobson-agents
/plugin install code-documentation@wshobson-agents

# Moodle specific
/plugin install moodle-dev-pro@astoeffer-plugins
/plugin install ai-app-dev@astoeffer-plugins
```

## DGX H100 Development

For GPU-accelerated development on the DGX H100 cluster:

1. **Use the dgx-h100-app template**:
```bash
cp -r project-templates/dgx-h100-app/.claude /path/to/project/
```

2. **Configure SSH** (`~/.ssh/config`):
```
Host deep-thought
    HostName 141.31.112.54
    IdentityFile ~/.ssh/your-key
    User your-username
```

3. **Connect with VS Code Remote SSH**

4. **Use SLURM for GPU jobs**:
```bash
sbatch job.sh  # Submit job
squeue -u $USER  # Check status
```
