# Claude Code Plugin Validation Rules

Complete reference of validation rules derived from system internals and debug log analysis.

---

## plugin.json Validation

### Required Fields

```json
{
  "name": "string",           // Required - kebab-case, unique
  "version": "string",        // Required - semantic versioning
  "description": "string",    // Required - clear purpose
  "author": {                 // Required
    "name": "string",         // Required
    "email": "string"         // Required
  }
}
```

### Optional Fields

```json
{
  "homepage": "string",       // URL to documentation
  "repository": "string",     // Git repository URL
  "license": "string",        // SPDX identifier
  "keywords": ["string"]      // Search tags
}
```

### Forbidden Fields

```json
{
  "commands": "./commands",     // ❌ Causes validation error
  "agents": "./agents",         // ❌ Must end with .md error
  "skills": "./skills",         // ❌ Not auto-discovered
  "hooks": "./hooks/hooks.json" // ❌ Manual specification fails
}
```

**Error**: `Validation errors: agents: Invalid input: must end with ".md"`

---

## marketplace.json Validation

### Required Structure

```json
{
  "$schema": "https://anthropic.com/claude-code/marketplace.schema.json",
  "name": "string",
  "version": "string",
  "description": "string",
  "owner": {
    "name": "string",
    "email": "string"
  },
  "plugins": [...]
}
```

### Plugin Entry Structure

```json
{
  "name": "string",
  "version": "string",
  "source": "./relative/path",
  "description": "string",
  "author": {
    "name": "string",
    "email": "string"
  },
  "category": "string"
}
```

### Common Mistakes

❌ Missing `$schema` → Marketplace not recognized
❌ Missing `version` → Validation fails
❌ Missing `owner.email` → Incomplete metadata
❌ Wrong plugin path → Components not found

---

## Component Validation

### Command Files

**Location**: `commands/*.md`

**Required Frontmatter**:
```yaml
---
name: command-name
description: "Command description"
---
```

**Optional Frontmatter**:
```yaml
category: productivity
complexity: basic | intermediate | advanced
```

**Validation Rules**:
- Must end with `.md`
- Must have YAML frontmatter
- name must match filename (without .md)
- description is required

---

### Agent Files

**Location**: `agents/*.md`

**Structure**:
```markdown
# Agent Name

**Role**: Brief description

**Expertise**:
- Area 1
- Area 2

[Content describing agent capabilities]
```

**Validation Rules**:
- Must end with `.md`
- Must have proper markdown structure
- Should define role and expertise
- Name should be descriptive

---

### Skill Files

**Location**: `skills/skill-name/SKILL.md`

**Structure**:
```markdown
# Skill Title

**Skill**: skill-name
**Version**: 1.0.0

[Knowledge content]
```

**Validation Rules**:
- Must be named `SKILL.md`
- Must be in subdirectory of `skills/`
- Should have skill metadata
- Content should be comprehensive

---

## System Registration

### installed_plugins.json

**Location**: `~/.claude/plugins/installed_plugins.json`

**Entry Format**:
```json
{
  "plugin-name@marketplace-name": {
    "version": "1.0.0",
    "installedAt": "2025-11-16T15:14:37.313Z",
    "lastUpdated": "2025-11-16T15:14:37.313Z",
    "installPath": "/absolute/path/to/plugin",
    "gitCommitSha": "abc123...",
    "isLocal": true
  }
}
```

**Validation**:
- All fields required
- installPath must exist
- gitCommitSha should match current commit
- Timestamps in ISO 8601 format

---

### known_marketplaces.json

**Location**: `~/.claude/plugins/known_marketplaces.json`

**Entry Format** (✅ CORRECT):
```json
{
  "marketplace-name": {
    "source": {
      "source": "github",
      "repo": "owner/repo-name"
    },
    "installLocation": "/absolute/path",
    "lastUpdated": "2025-11-16T15:26:44.679Z"
  }
}
```

**Wrong Format** (❌):
```json
{
  "marketplace-name": {
    "source": {
      "source": "git",
      "url": "https://github.com/owner/repo.git"
    }
  }
}
```

**Validation**:
- Source must be "github", NOT "git"
- Must use "repo" field, NOT "url"
- installLocation must exist
- lastUpdated in ISO 8601 format

---

## Auto-Discovery Rules

### How Components Are Found

1. **Commands**: All `.md` files in `commands/` directory
2. **Agents**: All `.md` files in `agents/` directory
3. **Skills**: All `SKILL.md` files in `skills/*/` subdirectories
4. **Hooks**: `hooks.json` file (if present)

### Directory Scanning

```
plugin-root/
├── commands/
│   ├── cmd1.md          ✅ Discovered
│   ├── cmd2.md          ✅ Discovered
│   └── README.md        ❌ Ignored (not a command)
├── agents/
│   ├── agent1.md        ✅ Discovered
│   └── helper.md        ✅ Discovered
└── skills/
    ├── skill1/
    │   └── SKILL.md     ✅ Discovered
    └── skill2/
        └── SKILL.md     ✅ Discovered
```

### Naming Conventions

**Commands**:
- `kebab-case-name.md`
- No spaces or special characters
- Descriptive verbs: `create-task.md`, `list-items.md`

**Agents**:
- `role-name.md` or `domain-expert.md`
- Suffix with purpose: `code-validator.md`

**Skills**:
- Directory: `kebab-case-name/`
- File: Always `SKILL.md` (case-sensitive)

---

## Error Messages Reference

### "Validation errors: agents: Invalid input: must end with .md"

**Cause**: plugin.json specifies component paths

**Location**: plugin.json

**Fix**: Remove these lines:
```json
"commands": "./commands",
"agents": "./agents",
"skills": "./skills"
```

---

### "Plugin not available for MCP: my-plugin - error type: generic-error"

**Causes**:
1. Invalid plugin.json structure
2. Component path specifications
3. Missing required fields

**Debug**:
```bash
/validate my-plugin
/debug-plugin my-plugin
```

---

### Marketplace Not Visible in UI

**Causes**:
1. Wrong source format ("git" instead of "github")
2. Missing marketplace.json metadata
3. Not registered in known_marketplaces.json

**Fix**:
- Check source type in known_marketplaces.json
- Verify marketplace.json has $schema, version, description
- Ensure proper registration

---

## Validation Checklist

Use this before publishing:

### Plugin Structure
- [ ] plugin.json exists in `.claude-plugin/`
- [ ] plugin.json is valid JSON
- [ ] All required fields present
- [ ] NO component path specifications
- [ ] Version follows semver

### Components
- [ ] All command files end with `.md`
- [ ] All commands have YAML frontmatter
- [ ] All agent files end with `.md`
- [ ] All skills have `SKILL.md` in subdirectory
- [ ] No duplicate component names

### Marketplace
- [ ] marketplace.json has $schema
- [ ] marketplace.json has version and description
- [ ] owner.email is present
- [ ] All plugin entries have version and author
- [ ] Source paths are correct

### System
- [ ] Plugin registered in installed_plugins.json
- [ ] Marketplace registered in known_marketplaces.json
- [ ] Source type is "github"
- [ ] Git commit SHA is current

### Testing
- [ ] Plugin loads without errors
- [ ] Commands appear in help
- [ ] Agents are accessible
- [ ] No errors in debug logs
- [ ] Marketplace visible in UI

---

## Debug Log Patterns

### Successful Load

```
[DEBUG] Loading plugins from ~/.claude/plugins
[DEBUG] Loaded plugin: my-plugin@my-marketplace
[DEBUG] Registered 3 commands, 2 agents, 1 skill
```

### Failed Load - Invalid Paths

```
[ERROR] Plugin not available for MCP: my-plugin
[DEBUG] Validation errors: agents: Invalid input: must end with ".md"
```

**Fix**: Remove component paths from plugin.json

### Failed Load - Missing Registration

```
[DEBUG] Loaded plugins - Enabled: 12, Disabled: 1, Commands: 22, Agents: 48, Errors: 0
```

Plugin not in count = not registered

**Fix**: Add to installed_plugins.json

---

## Performance Considerations

### File Size Limits

- plugin.json: < 10KB
- Commands: < 50KB each
- Agents: < 100KB each
- Skills: < 500KB each
- References: < 1MB each

### Component Limits

- Commands: < 20 per plugin (split if more)
- Agents: < 10 per plugin
- Skills: < 5 per plugin
- References: < 20 files

### Loading Time

Target: < 100ms per plugin
- Optimize file sizes
- Minimize component count
- Use lazy loading for references

---

## Version Compatibility

### Claude Code Version Support

This validation spec is based on Claude Code as of 2025-11-16.

Changes may occur in future versions:
- Monitor official documentation
- Check for validation changes
- Update plugins as needed

### Breaking Changes

Watch for:
- New required fields
- Component discovery changes
- Registration format changes
- Marketplace schema updates

---

## Testing Commands

```bash
# Validate plugin structure
/validate /path/to/plugin

# Debug loading issues
/debug-plugin my-plugin@marketplace

# Check registration
grep "my-plugin" ~/.claude/plugins/installed_plugins.json

# Monitor loading
tail -f ~/.claude/debug/latest | grep "my-plugin"

# Verify marketplace
cat ~/.claude/plugins/known_marketplaces.json | jq '.["my-marketplace"]'
```

---

## Quick Reference

**plugin.json**: Metadata only, NO paths
**Components**: Auto-discovered from directories
**Marketplace**: "github" source, complete metadata
**Registration**: Required in installed_plugins.json
**Validation**: Run before every publish

**Key Rule**: When in doubt, check debug logs and run `/validate`
