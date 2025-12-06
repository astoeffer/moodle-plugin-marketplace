---
name: plugin-validate
description: Validate Claude Code plugin structure, manifest, and components for errors and best practices
argument-hint: [plugin-directory]
---

# Validate Claude Code Plugin

Comprehensive validation of plugin structure, manifests, and components.

## Plugin Directory

Target: $1 (defaults to current directory if not provided)

## Validation Checks

### 1. Directory Structure
```
✓ Required:
  - .claude-plugin/plugin.json
  - README.md

✓ Optional (if referenced in plugin.json):
  - commands/
  - agents/
  - skills/
  - hooks/hooks.json or hooks/
  - .mcp.json
```

### 2. plugin.json Manifest

**Required Fields:**
- `name` (string, kebab-case, max 64 chars)

**Recommended Fields:**
- `version` (semantic versioning: "1.0.0")
- `description` (clear purpose, max 1024 chars)
- `author` (object with name/email)
- `license` (e.g., "MIT", "Apache-2.0")

**Component Paths:**
- If `commands` specified: directory must exist
- If `agents` specified: directory must exist
- If `skills` specified: directory must exist
- If `hooks` specified: file/directory must exist

**Validation:**
```bash
# Parse and validate JSON
jq empty .claude-plugin/plugin.json || echo "❌ Invalid JSON syntax"

# Check required fields
jq -r '.name' .claude-plugin/plugin.json | grep -E '^[a-z0-9-]{1,64}$' || echo "❌ Invalid plugin name"

# Validate component paths exist
if jq -e '.commands' .claude-plugin/plugin.json > /dev/null; then
  [ -d "$(jq -r '.commands' .claude-plugin/plugin.json)" ] || echo "❌ Commands directory not found"
fi
```

### 3. Commands Validation

For each `.md` file in `commands/`:

**Frontmatter YAML:**
```yaml
---
name: command-name           # Required: matches filename
description: "..."           # Recommended for SlashCommand tool
argument-hint: [args]        # Optional but helpful
allowed-tools: Read, Write   # Optional: restricts tools
model: sonnet                # Optional: override default
---
```

**Content:**
- Must have markdown content after frontmatter
- Can reference `$1`, `$2`, `$ARGUMENTS`
- Can use `!command` for bash execution
- Can use `@file.txt` for file inclusion

**Validation:**
```bash
# Check YAML frontmatter
head -n 20 commands/example.md | grep -q "^---$" || echo "❌ Missing frontmatter"

# Check name matches filename
grep "^name:" commands/example.md | grep "example" || echo "⚠️  Name mismatch"

# Check description exists (for auto-invocation)
grep "^description:" commands/example.md || echo "⚠️  Missing description"
```

### 4. Agents Validation

For each `.md` file in `agents/`:

**Frontmatter YAML:**
```yaml
---
name: agent-name                    # Required: kebab-case
description: "When to use..."      # Required: clear trigger description
tools: Read, Write, Bash           # Optional: tool restrictions
model: sonnet                      # Optional: model selection
---
```

**Content:**
- Must describe agent's expertise clearly
- Should include examples of when to activate
- Must specify tool usage patterns

**Validation:**
```bash
# Validate frontmatter
grep -q "^name:" agents/example.md || echo "❌ Missing name"
grep -q "^description:" agents/example.md || echo "❌ Missing description"

# Check description quality (length and clarity)
desc_length=$(grep "^description:" agents/example.md | wc -c)
[ $desc_length -gt 50 ] || echo "⚠️  Description too short (< 50 chars)"
[ $desc_length -lt 1024 ] || echo "❌ Description too long (> 1024 chars)"
```

### 5. Skills Validation

For each skill directory in `skills/*/`:

**Required Structure:**
```
skills/
└── skill-name/
    ├── SKILL.md (required)
    ├── reference.md (optional)
    ├── examples.md (optional)
    └── scripts/ (optional)
```

**SKILL.md Frontmatter:**
```yaml
---
name: skill-name                    # Required: matches directory, kebab-case, max 64
description: "When activates..."    # Required: clear activation triggers, max 1024
allowed-tools: Read, Grep           # Optional: tool restrictions
---
```

**Validation:**
```bash
# Check SKILL.md exists
[ -f "skills/example/SKILL.md" ] || echo "❌ SKILL.md not found"

# Validate naming
grep "^name:" skills/example/SKILL.md | grep -E '^name: [a-z0-9-]{1,64}$' || echo "❌ Invalid skill name"

# Check description triggers auto-activation
desc=$(grep "^description:" skills/example/SKILL.md)
echo "$desc" | grep -iE "when|use|working with|activates" || echo "⚠️  Description may not trigger auto-activation"
```

### 6. Hooks Validation

**If hooks/hooks.json exists:**

**Valid Events:**
- `PreToolUse`
- `PostToolUse`
- `UserPromptSubmit`
- `Stop`
- `SubagentStop`
- `SessionStart`
- `SessionEnd`
- `Notification`
- `PreCompact`

**Hook Structure:**
```json
{
  "EventName": [
    {
      "matcher": "pattern",
      "hooks": [
        {
          "type": "command",
          "command": "#!/bin/bash\n...",
          "timeout": 60000
        }
      ]
    }
  ]
}
```

**Validation:**
```bash
# Parse JSON
jq empty hooks/hooks.json || echo "❌ Invalid hooks.json syntax"

# Check event names
for event in $(jq -r 'keys[]' hooks/hooks.json); do
  echo "$event" | grep -E '^(PreToolUse|PostToolUse|UserPromptSubmit|Stop|SubagentStop|SessionStart|SessionEnd|Notification|PreCompact)$' || echo "❌ Invalid event: $event"
done

# Validate timeouts (max 600000ms = 10 minutes)
jq -r '.[].hooks[].timeout' hooks/hooks.json | while read timeout; do
  [ $timeout -le 600000 ] || echo "❌ Timeout too long: ${timeout}ms (max 600000)"
done
```

### 7. Security Checks

**Hook Commands:**
- ✓ No hardcoded secrets
- ✓ Proper variable quoting
- ✓ No path traversal vulnerabilities
- ✓ Safe bash practices

**Dangerous Patterns:**
```bash
# Check for dangerous commands
grep -r "rm -rf /" hooks/ && echo "❌ DANGEROUS: Recursive delete detected"
grep -r "eval " hooks/ && echo "⚠️  WARNING: eval usage detected"
grep -r "> /dev/sd" hooks/ && echo "❌ DANGEROUS: Direct disk write"

# Check for unquoted variables (potential injection)
grep -r '\$[A-Z_]*[^"]' hooks/ && echo "⚠️  Unquoted variables (potential injection risk)"
```

### 8. Best Practices

**README.md:**
- ✓ Describes plugin purpose
- ✓ Installation instructions
- ✓ Usage examples
- ✓ Configuration options

**Component Descriptions:**
- ✓ Clear activation triggers
- ✓ Realistic use cases
- ✓ Tool usage patterns
- ✓ Integration examples

**Documentation:**
- ✓ Comments in complex logic
- ✓ Examples for each component
- ✓ Troubleshooting section

## Validation Report Format

```
🔍 Plugin Validation Report

Plugin: my-awesome-plugin
Location: /path/to/plugin
Version: 1.0.0

=== CRITICAL ISSUES (0) ===
(None - ready for use!)

=== WARNINGS (2) ===
⚠️  commands/process.md: Description missing (recommended for auto-invocation)
⚠️  agents/helper.md: Description < 50 characters (may not trigger reliably)

=== PASSED CHECKS (23) ===
✅ plugin.json: Valid JSON syntax
✅ plugin.json: Required 'name' field present
✅ plugin.json: Valid plugin name format
✅ plugin.json: Semantic version format
✅ Directory structure: All referenced paths exist
✅ Commands: 3 commands validated
✅ Agents: 2 agents validated
✅ Skills: 1 skill validated
✅ Hooks: Valid hooks.json syntax
✅ Hooks: All event names valid
✅ Hooks: Timeout limits respected
✅ Security: No dangerous patterns detected
✅ README.md: Exists and comprehensive
... and 10 more

=== RECOMMENDATIONS ===
💡 Add 'repository' field to plugin.json for easier collaboration
💡 Include examples/ directory with sample usage
💡 Add LICENSE file for clarity

=== SUMMARY ===
Status: ✅ VALID (2 minor warnings)
Installation Ready: YES

Next Steps:
1. Fix warnings (optional but recommended)
2. Test locally: claude plugin install ./my-awesome-plugin
3. Publish to marketplace (if public)

Validation completed in 1.2s
```

## Exit Codes

- `0`: No critical issues (warnings OK)
- `1`: Critical issues found (not installable)
- `2`: Invalid plugin structure

## Usage Examples

```bash
# Validate current directory
/plugin-validate

# Validate specific plugin
/plugin-validate ./my-plugin

# Validate and auto-fix (if possible)
/plugin-validate ./my-plugin --fix

# Strict mode (warnings = errors)
/plugin-validate ./my-plugin --strict
```
