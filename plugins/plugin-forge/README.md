# Plugin Forge - Claude Code Meta-Plugin

**Streamline creation, validation, and testing of Claude Code plugins with scaffolding, best practices, and quality assurance.**

## What is Plugin Forge?

Plugin Forge is a meta-plugin that helps you build high-quality Claude Code plugins. It provides scaffolding tools, validation utilities, and expert guidance for plugin development.

Think of it as "create-react-app" for Claude Code plugins.

## Features

### 🏗️ **Scaffolding**
- `/plugin-new` - Create complete plugin structure
- Interactive wizard for component selection
- Pre-configured templates and examples
- Best practices baked in

### 🔍 **Validation**
- `/plugin-validate` - Comprehensive quality checks
- Manifest validation (plugin.json)
- Component structure verification
- Security auditing for hooks
- Best practices compliance

### 🧠 **Expert Guidance**
- **Plugin Architect Agent** - Design consultation
- Component selection advice
- Architecture patterns
- Integration strategies

## Installation

### Method 1: User-Level (Available Everywhere)

```bash
# Install to user plugins directory
mkdir -p ~/.claude/plugins
cp -r /path/to/plugin-forge ~/.claude/plugins/

# Enable plugin
claude plugin enable plugin-forge
```

### Method 2: Project-Level (Team Sharing)

```bash
# Copy to project
mkdir -p .claude/plugins
cp -r /path/to/plugin-forge .claude/plugins/

# Committed to git, team members auto-inherit
```

## Quick Start

### Create Your First Plugin

```bash
# Interactive creation
/plugin-new my-awesome-plugin

# With specific components
/plugin-new my-tool --with-commands --with-agents

# Full-featured plugin
/plugin-new advanced-plugin --with-commands --with-agents --with-skills --with-hooks
```

**Example Output:**
```
✅ Plugin Created: my-awesome-plugin

Directory Structure:
- plugin.json manifest configured
- ✓ commands/ with example command
- ✓ agents/ with example agent
- ✓ templates/ directory
- ✓ README.md documentation

Next Steps:
1. cd my-awesome-plugin
2. Edit components to add your logic
3. Test locally: claude plugin install ./my-awesome-plugin
4. Validate: /plugin-validate
```

### Validate Your Plugin

```bash
# Validate current directory
/plugin-validate

# Validate specific plugin
/plugin-validate ./my-plugin

# Strict mode (warnings = errors)
/plugin-validate ./my-plugin --strict
```

**Example Output:**
```
🔍 Plugin Validation Report

=== CRITICAL ISSUES (0) ===
(None - ready for use!)

=== WARNINGS (2) ===
⚠️  commands/process.md: Description missing
⚠️  agents/helper.md: Description < 50 chars

=== PASSED CHECKS (23) ===
✅ plugin.json: Valid JSON syntax
✅ Directory structure: Complete
✅ Commands: 3 validated
✅ Security: No dangerous patterns

Status: ✅ VALID (2 minor warnings)
```

## Components Guide

### Commands (User-Invoked)

**When to use:** Simple, frequently-used tasks that users explicitly trigger

**Structure:**
```markdown
---
name: my-command
description: What this command does
argument-hint: [arg1] [arg2]
---

# Command Content

Process arguments: $1, $2
Or all at once: $ARGUMENTS
```

**Example Use Cases:**
- Code generation templates
- File transformations
- Documentation generation
- Quick automations

### Agents (AI Specialists)

**When to use:** Complex, domain-specific guidance requiring expertise

**Structure:**
```markdown
---
name: my-expert
description: Expert in X, helping with Y and Z tasks
tools: Read, Write, Bash
model: sonnet
---

# System Prompt

You are an expert in [domain]...
```

**Example Use Cases:**
- Code review and refactoring
- Architecture design
- Security auditing
- Domain expertise

### Skills (Auto-Activated)

**When to use:** Background validation, context-aware assistance

**Structure:**
```
skills/
└── my-skill/
    ├── SKILL.md (required)
    ├── reference.md (optional)
    └── scripts/ (optional)
```

**Example Use Cases:**
- Code standards validation
- Accessibility checking
- Performance analysis
- Security scanning

### Hooks (Event-Driven)

**When to use:** Workflow automation, validation gates

**Structure:**
```json
{
  "PreToolUse": [
    {
      "matcher": "Bash(git commit:*)",
      "hooks": [{"type": "command", "command": "..."}]
    }
  ]
}
```

**Example Use Cases:**
- Pre-commit validation
- Auto-formatting
- Environment setup
- Notification integration

## Decision Matrix

| Need | Use | Invocation | Complexity |
|------|-----|------------|------------|
| Simple task automation | Commands | Explicit `/cmd` | Low |
| Expert guidance | Agents | Auto + Explicit | High |
| Background validation | Skills | Automatic | Medium |
| Workflow automation | Hooks | Event-triggered | Medium |

## Plugin Architecture Patterns

### Pattern 1: Simple Productivity
**Components:** Commands only

```
snippet-generator/
├── .claude-plugin/plugin.json
├── commands/
│   ├── react-component.md
│   ├── unit-test.md
│   └── api-route.md
└── README.md
```

**Best for:** Code generators, templates, simple automations

### Pattern 2: Domain Expert
**Components:** Agents + Skills

```
legal-assistant/
├── .claude-plugin/plugin.json
├── agents/
│   ├── contract-reviewer.md
│   └── compliance-checker.md
├── skills/
│   ├── gdpr-validator/
│   └── clause-analyzer/
└── README.md
```

**Best for:** Specialized knowledge domains, consulting

### Pattern 3: Code Quality
**Components:** Skills + Hooks

```
code-guardian/
├── .claude-plugin/plugin.json
├── skills/
│   ├── linter/
│   └── security-scanner/
├── hooks/hooks.json
└── README.md
```

**Best for:** Quality assurance, standards enforcement

### Pattern 4: Comprehensive Development
**Components:** All of the above

```
moodle-dev-pro/
├── .claude-plugin/plugin.json
├── commands/         # Workflows
├── agents/           # Experts
├── skills/           # Auto-validation
├── hooks/            # Automation
└── README.md
```

**Best for:** Full development environments, frameworks

## Plugin Architect Agent

Get expert guidance on plugin design:

```
You: I want to create a plugin for React development

Plugin Architect:
Analyzes your needs and recommends:
- Component selection (commands vs agents vs skills)
- Directory structure
- Tool requirements
- Integration patterns
- Security considerations

Provides:
- Architecture blueprint
- Component templates
- Best practices
- Example implementations
```

**The agent helps with:**
- Component selection decisions
- Architecture design
- Security auditing
- Best practices guidance
- Integration strategies

## Validation Checks

### Manifest (plugin.json)
- ✓ Valid JSON syntax
- ✓ Required 'name' field
- ✓ Semantic versioning
- ✓ Valid component paths
- ✓ Proper metadata

### Commands
- ✓ Valid YAML frontmatter
- ✓ Name matches filename
- ✓ Description present
- ✓ Proper argument handling

### Agents
- ✓ Clear activation triggers
- ✓ Tool restrictions
- ✓ Model selection
- ✓ Expertise defined

### Skills
- ✓ SKILL.md exists
- ✓ Name format (kebab-case)
- ✓ Description triggers activation
- ✓ Tool restrictions

### Hooks
- ✓ Valid event names
- ✓ Timeout limits
- ✓ Security patterns
- ✓ Proper exit codes

### Security
- ✓ No hardcoded secrets
- ✓ Quoted variables
- ✓ No dangerous commands
- ✓ Path traversal protection

## Examples

### Example 1: Code Snippet Generator

```bash
/plugin-new code-snippets --with-commands

# Creates:
code-snippets/
├── .claude-plugin/plugin.json
├── commands/
│   ├── snippet-react.md
│   ├── snippet-test.md
│   └── snippet-api.md
└── README.md

# Edit commands to add your snippets
# Test: claude plugin install ./code-snippets
# Use: /snippet-react MyComponent
```

### Example 2: Security Auditor

```bash
/plugin-new security-auditor --with-agents --with-skills

# Creates:
security-auditor/
├── agents/
│   └── security-expert.md
├── skills/
│   ├── sql-injection-detector/
│   └── xss-scanner/
└── README.md

# Customize agents and skills
# Test plugin
# Validate: /plugin-validate
```

### Example 3: Test Framework

```bash
/plugin-new test-framework --with-commands --with-skills --with-hooks

# Full-featured plugin:
test-framework/
├── commands/
│   └── run-tests.md
├── skills/
│   └── test-coverage-analyzer/
├── hooks/
│   └── hooks.json  # Pre-commit test enforcement
└── README.md
```

## Best Practices

### DO ✅
- Start simple, add complexity as needed
- Clear, descriptive component names
- Comprehensive descriptions
- Real-world examples
- Security-first for hooks
- Semantic versioning
- User-friendly documentation

### DON'T ❌
- Create monolithic components
- Use vague descriptions
- Hardcode secrets
- Skip validation
- Ignore security
- Break compatibility without version bump
- Use technical jargon

## Workflow

### 1. Planning
```
You: I need a plugin for [purpose]

Plugin Architect Agent:
- Analyzes requirements
- Recommends components
- Suggests architecture
- Provides template
```

### 2. Creation
```
/plugin-new my-plugin --with-[components]

- Generates structure
- Creates examples
- Sets up manifest
- Initializes git
```

### 3. Development
```
- Replace examples with logic
- Test each component
- Add documentation
- Create usage examples
```

### 4. Validation
```
/plugin-validate

- Check structure
- Validate manifests
- Security audit
- Best practices
```

### 5. Testing
```
claude plugin install ./my-plugin

- Install locally
- Test all components
- Verify integration
- Fix issues
```

### 6. Distribution
```
- Tag version
- Push to git
- Submit to marketplace (optional)
- Gather feedback
```

## Troubleshooting

### Plugin Not Loading
```bash
# Check installation
claude plugin list

# Enable if needed
claude plugin enable plugin-forge

# Restart Claude
claude --restart
```

### Validation Failing
```bash
# Run validation
/plugin-validate ./my-plugin

# Check specific issues
cat .claude-plugin/plugin.json | jq .

# Fix and re-validate
/plugin-validate ./my-plugin
```

### Components Not Working
```bash
# Check frontmatter syntax
head -20 commands/example.md

# Validate JSON (hooks)
jq empty hooks/hooks.json

# Test individually
claude --debug
```

## Advanced Topics

### MCP Server Integration
```json
{
  "name": "my-plugin",
  ".mcp.json": {
    "mcpServers": {
      "my-server": {
        "command": "node",
        "args": ["${CLAUDE_PLUGIN_ROOT}/server.js"]
      }
    }
  }
}
```

### Environment Variables
```bash
# In hooks
${CLAUDE_PROJECT_DIR}    # Project root
${CLAUDE_PLUGIN_ROOT}    # Plugin directory
${CLAUDE_ENV_FILE}       # Persistent env vars
```

### Progressive Disclosure
```
skills/
└── complex-skill/
    ├── SKILL.md          # Brief instructions
    ├── reference.md      # Detailed reference
    ├── examples.md       # Usage examples
    └── scripts/          # Helper scripts
```

## Contributing

This plugin helps create plugins! Meta, right?

To improve Plugin Forge:
1. Fork repository
2. Add features
3. Test thoroughly
4. Submit PR

## Resources

- [Claude Code Plugin Docs](https://code.claude.com/docs/en/plugins)
- [Commands Guide](https://code.claude.com/docs/en/slash-commands)
- [Agents Guide](https://code.claude.com/docs/en/sub-agents)
- [Skills Guide](https://code.claude.com/docs/en/skills)
- [Hooks Guide](https://code.claude.com/docs/en/hooks)

## License

MIT License - see LICENSE file

## Support

- GitHub: https://github.com/astoeffer/plugin-forge
- Issues: https://github.com/astoeffer/plugin-forge/issues

---

**Happy Plugin Building! 🚀**
