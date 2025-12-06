# Moodle Dev Pro - Claude Code Plugin

**Comprehensive Moodle plugin and theme development with Docker multi-version support, accessibility focus, and UX best practices.**

## Features

### 🏗️ **Specialized Agents**
- **Moodle Architect**: Expert plugin design, API integration, security model
- **Accessibility Specialist**: WCAG 2.1 AA compliance, screen reader testing
- **Docker Ops**: Multi-version management (Moodle 4.1/4.5/5.1)

### 🤖 **Auto-Activated Skills**
- **PSR-12 Moodle Compliance**: Automatic code standards validation
- **WCAG Validator**: Accessibility checking for templates & JavaScript

### ⚡ **Slash Commands**
- `/m:implement` - Feature implementation with standards compliance
- `/m:troubleshoot` - Issue diagnosis with GitHub integration
- `/m:git` - Git workflow with Moodle conventions
- `/m:task` - Complex task management with MCP integration
- `/m:test` - PHPUnit, Behat, code standards testing

### 🎯 **Automated Hooks**
- Pre-commit code standards validation
- Auto-formatting on file write/edit
- Accessibility reminders for UI work
- Session startup context loading

## Installation

### Method 1: Local Plugin (Development)

```bash
# Clone or copy plugin to Claude plugins directory
mkdir -p ~/.claude/plugins
cp -r /opt/moodle-dev/.claude-plugins/moodle-dev-pro ~/.claude/plugins/

# Enable plugin
claude plugin enable moodle-dev-pro
```

### Method 2: Project-Level (Team Sharing)

```bash
# Plugin already in project at:
# /opt/moodle-dev/.claude-plugins/moodle-dev-pro

# Claude Code will auto-discover when you trust the directory
# Settings > Trust Directory
```

## Quick Start

### 1. Create New Moodle Plugin

```
You: Create a new activity module called "Interactive Quiz" with mobile support

Claude (via Moodle Architect):
- Analyzes requirements
- Designs file structure
- Creates database schema (XMLDB)
- Defines capabilities
- Generates boilerplate code
- Plans Web Services for mobile
- Ensures WCAG 2.1 AA compliance
```

### 2. Install & Test Across Versions

```
You: /m:install mod/interactivequiz --all

Docker Ops Agent:
- Installs to Moodle 4.1, 4.5, and 5.1
- Runs CLI upgrade for each
- Purges caches
- Reports compatibility status
```

### 3. Run Comprehensive Tests

```
You: /m:test --type all

Test Suite:
✓ PSR-12 code standards (phpcs)
✓ PHPUnit unit tests
✓ Behat acceptance tests
✓ Accessibility audit (WCAG 2.1 AA)
✓ Cross-version compatibility (4.1/4.5/5.1)
```

## Environment Integration

### Multi-Version Moodle Setup

This plugin is designed for your specific environment:

```
Moodle 4.1 (PHP 8.1): https://moodle41.learnforge.de
Moodle 4.5 (PHP 8.2): https://moodle45.learnforge.de
Moodle 5.1 (PHP 8.3): https://moodle51.learnforge.de

Data directories:
- /workspace/moodledata-41/
- /workspace/moodledata-45/
- /workspace/moodledata-51/

Moodle installations:
- /opt/moodle-MOODLE_401_STABLE/
- /opt/moodle-MOODLE_405_STABLE/
- /opt/moodle-MOODLE_501_STABLE/
```

### Docker Operations

**Install plugin to specific version:**
```bash
/m:install mod/myplugin --version 5.1
```

**Test across all versions:**
```bash
/m:test mod/myplugin --versions all
```

**Enable Xdebug for debugging:**
```bash
/m:debug enable --version 5.1
# Debug session...
/m:debug disable --version 5.1
```

## Agent Usage

### Moodle Architect

**When to use:** Plugin design, architecture decisions, API integration

```
You: Design a plugin that integrates Nextcloud folders into Moodle

Architect:
1. Recommends activity module (mod_nextcloudfolder)
2. Designs OAuth2 authentication flow
3. Plans database schema for folder metadata
4. Defines capabilities (viewfolder, downloadfiles, managefolder)
5. Designs Web Services API for mobile app
6. Ensures accessibility in file browser UI
```

### Accessibility Specialist

**When to use:** UI development, template creation, JavaScript components

```
You: Create a modal dialog for file upload

A11Y Specialist:
1. Designs with proper ARIA roles (role="dialog")
2. Implements keyboard focus trapping
3. Adds screen reader announcements
4. Ensures 4.5:1 color contrast
5. Validates keyboard navigation (Tab, Escape)
6. Tests with NVDA/VoiceOver
```

### Docker Ops

**When to use:** Installation, testing, deployment, debugging

```
You: Install my plugin to all Moodle versions and run tests

Docker Ops:
1. Detects plugin type and location
2. Copies to all 3 Moodle installations
3. Runs CLI upgrade for each version
4. Executes PHPUnit test suite per version
5. Reports compatibility matrix
6. Identifies version-specific issues
```

## Skills (Auto-Activated)

### PSR-12 Moodle Compliance

**Activates when:**
- Writing/editing PHP files
- Mentions: "code standards", "PSR-12", "refactor"

**Actions:**
- Validates naming conventions (lowercase_with_underscores)
- Checks frankenstyle prefixes
- Runs phpcs with Moodle standard
- Suggests fixes with phpcbf
- Reports compliance score

### WCAG Validator

**Activates when:**
- Working with Mustache templates
- Editing AMD JavaScript modules
- Mentions: "accessibility", "a11y", "WCAG"

**Actions:**
- Scans for missing alt text
- Validates form label associations
- Checks ARIA patterns
- Measures color contrast
- Tests keyboard navigation
- Reports WCAG 2.1 AA compliance

## Hooks

### Pre-Commit Validation

Runs before `git commit`:
- ✓ PHPCodeSniffer (PSR-12/Moodle)
- ✓ Accessibility checks (templates)
- ⚠️ Debugging code detection
- 🚫 Blocks commit if critical issues found

### Auto-Formatting

Runs after `Write`/`Edit`:
- Automatically formats PHP files with phpcbf
- Applies Moodle coding standards
- Non-blocking (warnings only)

### Session Start

On Claude Code startup:
- Displays environment info
- Lists available commands
- Shows active agents & skills

### Accessibility Reminders

On prompt submit:
- Detects UI-related work
- Reminds about WCAG 2.1 AA
- Suggests A11Y Specialist agent

## Workflow Examples

### Example 1: New Plugin Development

```
1. You: Create a new block plugin for displaying course statistics

2. Moodle Architect:
   - Creates block_coursestats/ directory structure
   - Generates version.php, block_coursestats.php, db/access.php
   - Defines capability: block/coursestats:view
   - Creates language strings
   - Designs responsive card layout

3. PSR-12 Skill (auto):
   - Validates all generated code
   - Ensures frankenstyle naming
   - Reports: ✓ 100% compliant

4. You: Add a settings page

5. Moodle Architect:
   - Creates settings.php with proper form API
   - Implements capability checks
   - Adds accessible form labels

6. WCAG Validator (auto):
   - Checks form accessibility
   - Reports: ✓ WCAG 2.1 AA compliant

7. You: /m:install block/coursestats --all

8. Docker Ops:
   - Installs to Moodle 4.1, 4.5, 5.1
   - Reports: ✓ Compatible with all versions

9. You: /m:test block/coursestats --all

10. Test Results:
    ✓ Code standards: PASSED
    ✓ PHPUnit: 12/12 tests passed
    ✓ Behat: 5/5 scenarios passed
    ✓ Accessibility: WCAG 2.1 AA compliant
    ✓ Cross-version: Compatible with 4.1/4.5/5.1
```

### Example 2: Accessibility Audit

```
1. You: /m:a11y audit mod/nextcloudfolder

2. Accessibility Specialist:
   - Scans all templates
   - Analyzes JavaScript components
   - Tests keyboard navigation
   - Measures color contrast

3. Report:
   ❌ 8 critical issues
   ⚠️  12 warnings
   ✅ 45 checks passed

   Compliance: 72% → Target: 100%

4. Priority fixes provided:
   - Add alt text to 3 images
   - Associate form labels (5 inputs)
   - Fix modal focus trapping
   - Improve color contrast (2 elements)

5. You: Apply these fixes

6. A11Y Specialist:
   - Generates corrected code
   - Explains each fix
   - Re-validates

7. Final Report:
   ✅ 100% WCAG 2.1 AA compliant
```

### Example 3: Cross-Version Testing

```
1. You: Test my plugin across all Moodle versions

2. Docker Ops:
   === Cross-Version Testing: mod_interactivequiz ===

   Testing Moodle 4.1...
   ✓ PHPUnit: 24/24 passed
   ✓ Behat: 8/8 passed
   ✓ Moodle 4.1: COMPATIBLE

   Testing Moodle 4.5...
   ✓ PHPUnit: 24/24 passed
   ✓ Behat: 8/8 passed
   ✓ Moodle 4.5: COMPATIBLE

   Testing Moodle 5.1...
   ✗ PHPUnit: 2 tests failed
   ✗ API change detected: quiz_get_user_attempts() signature changed
   ⚠️  Moodle 5.1: INCOMPATIBLE

3. Fix recommendations:
   - Update to new API in Moodle 5.1
   - Add version check in code
   - Or: require Moodle 4.1-4.5 only

4. You implement fix with guidance from Moodle Architect

5. Retest:
   ✓ All versions now compatible
```

## Configuration

### Custom Paths

Edit [plugin.json](.claude-plugin/plugin.json):

```json
{
  "commands": "./commands",
  "agents": "./agents",
  "skills": "./skills",
  "hooks": "./hooks/hooks.json"
}
```

### Tool Permissions

Edit agent markdown files to restrict tools:

```yaml
---
name: moodle-architect
tools: Read, Write, Edit, Grep, Glob, Bash, TodoWrite
---
```

### Hook Timeouts

Edit `hooks/hooks.json`:

```json
{
  "PreToolUse": [
    {
      "hooks": [
        {
          "timeout": 60000  // milliseconds
        }
      ]
    }
  ]
}
```

## Troubleshooting

### Plugin Not Loading

```bash
# Check if plugin is enabled
claude plugin list

# Enable if disabled
claude plugin enable moodle-dev-pro

# Restart Claude Code
claude --restart
```

### Commands Not Working

```bash
# Verify commands directory
ls ~/.claude/plugins/moodle-dev-pro/commands/

# Check command format
head ~/.claude/plugins/moodle-dev-pro/commands/m-implement.md
```

### Agents Not Activating

```bash
# List available agents
claude agents list

# Check agent description is clear
# Agent descriptions trigger automatic activation
```

### Hooks Not Running

```bash
# Test hook manually
bash -c "$(cat ~/.claude/plugins/moodle-dev-pro/hooks/hooks.json | jq -r '.SessionStart[0].hooks[0].command')"

# Check hook permissions
chmod +x ~/.claude/plugins/moodle-dev-pro/hooks/*.sh
```

## Development

### Adding New Commands

1. Create markdown file in `commands/`:

```markdown
---
name: my-command
description: What it does
---

# Command content
```

2. Use in Claude Code: `/my-command [args]`

### Adding New Agents

1. Create markdown file in `agents/`:

```markdown
---
name: my-agent
description: When to use this agent
tools: Read, Write, Bash
model: sonnet
---

# Agent system prompt
```

2. Claude auto-discovers and invokes based on description

### Adding New Skills

1. Create skill directory in `skills/my-skill/`
2. Add `SKILL.md`:

```markdown
---
name: my-skill
description: When this skill activates
allowed-tools: Read, Grep
---

# Skill instructions
```

3. Skill activates automatically based on description match

## Contributing

This plugin is customized for the multi-version Moodle environment at learnforge.de. To adapt for other setups:

1. Update paths in `agents/docker-ops.md`
2. Modify environment detection logic
3. Adjust database credentials (use environment variables)
4. Update documentation with your URLs

## License

MIT License - see LICENSE file

## Support

- GitHub: https://github.com/astoeffer/moodle-dev-pro
- Issues: https://github.com/astoeffer/moodle-dev-pro/issues
- Moodle Development: https://moodledev.io

## Related

- **Plugin Forge**: Meta-plugin for creating Claude Code plugins (coming soon)
- **Moodle Docker Remote Dev**: https://github.com/astoeffer/moodle-docker-remote-dev
