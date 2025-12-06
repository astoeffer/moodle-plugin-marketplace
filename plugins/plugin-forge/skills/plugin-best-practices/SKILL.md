# Claude Code Plugin Development Best Practices

**Skill**: plugin-best-practices
**Version**: 1.0.0
**Last Updated**: 2025-11-16
**Derived From**: Real-world debugging of plugin loading failures

## Purpose

Comprehensive knowledge base of Claude Code plugin development patterns, validation rules, and common pitfalls learned from actual plugin system internals.

---

## Critical Rules (MUST FOLLOW)

### Rule 1: plugin.json Contains ONLY Metadata

**✅ CORRECT**:
```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "What the plugin does",
  "author": {
    "name": "Your Name",
    "email": "you@example.com"
  },
  "keywords": ["tag1", "tag2"]
}
```

**❌ WRONG** (causes validation error):
```json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "commands": "./commands",     // ❌ REMOVE THIS
  "agents": "./agents",         // ❌ REMOVE THIS
  "skills": "./skills",         // ❌ REMOVE THIS
  "hooks": "./hooks/hooks.json" // ❌ REMOVE THIS
}
```

**Why**: Claude Code uses auto-discovery for components. Manual paths cause validation errors: "agents: Invalid input: must end with .md"

**Error in Debug Logs**:
```
[ERROR] Plugin not available for MCP: my-plugin
[DEBUG] Validation errors: agents: Invalid input: must end with ".md"
```

---

### Rule 2: Components Are Auto-Discovered

Claude Code automatically finds:
- **Commands**: `commands/*.md`
- **Agents**: `agents/*.md`
- **Skills**: `skills/*/SKILL.md`
- **Hooks**: `hooks.json` (if needed)

**Directory Structure**:
```
my-plugin/
├── .claude-plugin/
│   └── plugin.json       # Metadata only
├── commands/             # Auto-discovered
│   ├── hello.md
│   └── task.md
├── agents/               # Auto-discovered
│   └── helper.md
└── skills/               # Auto-discovered
    └── my-skill/
        └── SKILL.md
```

---

### Rule 3: Marketplace Source Must Be "github"

**✅ CORRECT** (appears in plugin manager):
```json
{
  "moodle-plugins-marketplace": {
    "source": {
      "source": "github",
      "repo": "owner/repo-name"
    },
    "installLocation": "...",
    "lastUpdated": "2025-11-16T15:26:44.679Z"
  }
}
```

**❌ WRONG** (marketplace invisible):
```json
{
  "moodle-plugins-marketplace": {
    "source": {
      "source": "git",
      "url": "https://github.com/owner/repo-name.git"
    }
  }
}
```

**Why**: Claude Code UI only recognizes "github" source type, not "git" URL format.

---

### Rule 4: marketplace.json Must Have Complete Metadata

**✅ CORRECT**:
```json
{
  "$schema": "https://anthropic.com/claude-code/marketplace.schema.json",
  "name": "my-marketplace",
  "version": "1.0.0",
  "description": "Marketplace description",
  "owner": {
    "name": "Your Name",
    "email": "you@example.com"
  },
  "plugins": [...]
}
```

**❌ WRONG** (marketplace won't load):
```json
{
  "name": "my-marketplace",
  "owner": {
    "name": "Your Name"
  },
  "plugins": [...]
}
```

**Missing**:
- `$schema` - JSON schema reference
- `version` - Marketplace version
- `description` - What marketplace provides
- `owner.email` - Contact email

---

### Rule 5: Plugins Must Be Registered to Appear

Plugins must exist in `~/.claude/plugins/installed_plugins.json`:

```json
{
  "version": 1,
  "plugins": {
    "my-plugin@my-marketplace": {
      "version": "1.0.0",
      "installedAt": "2025-11-16T15:14:37.313Z",
      "lastUpdated": "2025-11-16T15:14:37.313Z",
      "installPath": "/path/to/plugin",
      "gitCommitSha": "abc123...",
      "isLocal": true
    }
  }
}
```

**Without registration**: Plugin exists but is invisible to UI

---

## Component Design Patterns

### Command Structure

**Frontmatter**:
```yaml
---
name: my-command
description: "What this command does"
category: productivity
---
```

**Sections**:
1. Description and purpose
2. Usage examples
3. Options and parameters
4. Common use cases
5. Error handling
6. See also (related commands)

**Example**:
```markdown
---
name: hello
description: "Greet the user"
---

# /hello - Greeting Command

Provides personalized greeting.

## Usage

```
/hello [name]
```

## Examples

```
/hello Alice
→ Hello, Alice!

/hello
→ Hello there!
```
```

---

### Agent Structure

**Format**:
```markdown
# Agent Name

**Role**: Brief role description

**Expertise**:
- Area 1
- Area 2
- Area 3

## When to Use This Agent

- Scenario 1
- Scenario 2

## Agent Capabilities

### Capability 1
Description and examples

### Capability 2
Description and examples

## Example Interactions

### Scenario A
**User**: Question
**Agent**: Response

## Key Principles

1. Principle 1
2. Principle 2
```

---

### Skill Structure

**SKILL.md Format**:
```markdown
# Skill Title

**Skill**: skill-name
**Version**: 1.0.0
**Last Updated**: 2025-11-16

## Purpose

What knowledge this skill provides

## Core Concepts

### Concept 1
Details and examples

### Concept 2
Details and examples

## Best Practices

1. Practice 1
2. Practice 2

## Common Patterns

### Pattern 1
```code example```

### Pattern 2
```code example```

## Anti-Patterns

❌ What not to do
✅ What to do instead

## Reference

- External links
- Related documentation
```

---

## Validation Checklist

Before publishing, verify:

### Plugin Structure
- [ ] `.claude-plugin/plugin.json` exists
- [ ] plugin.json is valid JSON
- [ ] plugin.json contains NO component paths
- [ ] Required fields: name, version, description, author

### Components
- [ ] Command files end with `.md`
- [ ] Command files have YAML frontmatter
- [ ] Agent files end with `.md`
- [ ] Skill directories contain `SKILL.md`

### Marketplace (if applicable)
- [ ] `marketplace.json` has `$schema`
- [ ] `marketplace.json` has version
- [ ] `marketplace.json` has description
- [ ] `owner.email` present
- [ ] All plugins have version and author

### System Registration
- [ ] Plugin in `installed_plugins.json`
- [ ] Marketplace in `known_marketplaces.json`
- [ ] Source type is "github", not "git"

### Testing
- [ ] Plugin loads without errors
- [ ] Commands appear in `/help`
- [ ] Agents are accessible
- [ ] Skills load properly
- [ ] No errors in debug logs

---

## Common Pitfalls

### Pitfall 1: Specifying Component Paths

**Symptom**: Plugin doesn't load, debug logs show validation error

**Cause**: plugin.json contains `"commands": "./commands"`

**Fix**: Remove all component path specifications

---

### Pitfall 2: Wrong Marketplace Source Format

**Symptom**: Marketplace not visible in plugin manager UI

**Cause**: Using "git" instead of "github" in `known_marketplaces.json`

**Fix**: Change to "github" format with "repo" field

---

### Pitfall 3: Missing Marketplace Metadata

**Symptom**: Marketplace installed but not showing

**Cause**: Missing `$schema`, `version`, or `description` in marketplace.json

**Fix**: Add all required fields to marketplace.json

---

### Pitfall 4: Plugin Not Registered

**Symptom**: Plugin files exist but invisible

**Cause**: Missing entry in `installed_plugins.json`

**Fix**: Add plugin registration with proper metadata

---

### Pitfall 5: Incorrect Git Commit SHA

**Symptom**: Plugin shows as outdated or has version mismatch

**Cause**: `gitCommitSha` in installed_plugins.json doesn't match actual commit

**Fix**: Update SHA to current commit hash

---

## Performance Best Practices

### Keep Files Lean

❌ **Bad**: 10MB reference file in plugin
✅ **Good**: Link to external documentation

### Optimize Component Count

❌ **Bad**: 50 commands in one plugin
✅ **Good**: Split into focused plugins

### Use Lazy Loading

❌ **Bad**: Load all data at plugin init
✅ **Good**: Load on-demand when command invoked

---

## Naming Conventions

### Plugin Names
- Use kebab-case: `my-plugin-name`
- Be specific: `moodle-dev-pro` not `dev-tools`
- Avoid generic names: `helper`, `utils`, `toolkit`

### Command Names
- Use verb-noun: `create-task`, `list-items`
- Be concise: `hello` not `say-hello-to-user`
- Use hyphens: `my-command` not `my_command`

### Agent Names
- Use noun or role: `validator`, `architect`
- Be descriptive: `plugin-validator` not `helper`
- Suffix with purpose: `migration-validator`

### Skill Names
- Use domain-focus: `database-best-practices`
- Be specific: `plugin-architecture-patterns`
- Use hyphens: `code-review-guidelines`

---

## Security Considerations

### Never Commit
- API keys or tokens
- Passwords or credentials
- `.env` files with secrets

### Safe Patterns
- Use environment variables
- Reference credential locations
- Document security setup
- Validate user inputs

### File Permissions
```bash
chmod 600 .env           # Credentials read-only by owner
chmod 644 plugin.json    # Config readable by all
chmod 755 scripts/       # Scripts executable
```

---

## Testing Strategy

### Local Testing
1. Copy to `~/.claude/plugins/local/my-plugin`
2. Restart Claude Code
3. Check debug logs for errors
4. Test each command manually
5. Verify agents are invoked

### Validation Testing
```bash
/validate my-plugin
/debug-plugin my-plugin
```

### Integration Testing
- Test with other plugins
- Check for naming conflicts
- Verify no performance degradation

---

## Distribution Checklist

### Pre-Release
- [ ] All validation checks pass
- [ ] No errors in debug logs
- [ ] README is comprehensive
- [ ] Examples are provided
- [ ] Version number updated

### GitHub Release
- [ ] Code committed and pushed
- [ ] Tag created: `v1.0.0`
- [ ] Release notes written
- [ ] Installation instructions included

### Marketplace Update
- [ ] marketplace.json updated
- [ ] Plugin version incremented
- [ ] Git commit SHA updated
- [ ] Marketplace pushed to GitHub

---

## Debugging Workflow

When plugin doesn't load:

1. **Check Debug Logs**
   ```bash
   tail -f ~/.claude/debug/latest
   ```

2. **Run Validation**
   ```bash
   /validate my-plugin
   ```

3. **Check Registration**
   ```bash
   cat ~/.claude/plugins/installed_plugins.json | grep my-plugin
   ```

4. **Verify Structure**
   ```bash
   ls -la ~/.claude/plugins/marketplaces/my-marketplace/my-plugin/
   ```

5. **Fix and Restart**
   - Apply fixes
   - Restart Claude Code
   - Verify in plugin manager

---

## Version Management

### Semantic Versioning

- **Major** (1.0.0 → 2.0.0): Breaking changes
- **Minor** (1.0.0 → 1.1.0): New features, backward compatible
- **Patch** (1.0.0 → 1.0.1): Bug fixes

### Update Process

1. Update plugin version in `plugin.json`
2. Update marketplace version if needed
3. Commit changes with version tag
4. Update `gitCommitSha` in `installed_plugins.json`
5. Push to GitHub

---

## Resources

### Official Documentation
- Claude Code Docs: https://code.claude.com/docs/en/plugins
- Plugin Examples: Official plugin repositories

### Validation Tools
- JSON validators for config files
- Markdown linters for component files
- Git hooks for pre-commit checks

### Community
- GitHub Issues for bug reports
- Discussions for feature requests
- Plugin marketplace for examples

---

## Summary

**Golden Rules**:
1. plugin.json = metadata only (NO paths)
2. Components = auto-discovered
3. Marketplace source = "github" format
4. Complete metadata = required
5. Registration = necessary for visibility

**When in Doubt**:
- Run `/validate`
- Check debug logs
- Compare with working plugins
- Use `/debug-plugin` for diagnosis

**Remember**: These rules come from real debugging experience. Following them prevents the most common plugin loading failures.
