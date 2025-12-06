# Custom Moodle Commands - Protection Strategy

## Overview
This directory contains **custom slash commands** specifically designed for Moodle plugin development. These commands are maintained separately from SuperClaude's default commands to prevent them from being overwritten during SuperClaude Framework updates.

## Location Strategy

### During Development (Host/Workspace)
```
/workspace/.claude/commands/m/
```
- Your custom commands live here during development
- Version controlled with your project
- Editable and maintainable

### During Container Build
The Dockerfile copies these commands to SuperClaude's command directory:
```dockerfile
COPY --chown=node:node .claude/commands/m /home/node/.claude/commands/m
```

### In Container Runtime
```
/home/node/.claude/commands/m/
```
- SuperClaude reads commands from here
- Isolated in `/m/` subdirectory
- Protected from SuperClaude updates (which install to root level)

## Available Custom Commands

| Command | Description | File |
|---------|-------------|------|
| `/m:implement` | Feature implementation with PSR-12 compliance | [implement.md](implement.md) |
| `/m:troubleshoot` | Issue diagnosis with GitHub integration | [troubleshoot.md](troubleshoot.md) |
| `/m:git` | Git workflow with Moodle conventions | [git.md](git.md) |
| `/m:task` | Complex task management with MCP integration | [task.md](task.md) |
| `/m:test` | PHPUnit, Behat, and code standards testing | [test.md](test.md) |

## Usage Examples

### Feature Implementation
```bash
/m:implement OAuth2 authentication --type activity
```

### Issue Troubleshooting
```bash
/m:troubleshoot "Could not connect to Nextcloud" --search-issues
```

### Git Workflow
```bash
/m:git feature issue-53-subfolder-browse
```

### Task Management
```bash
/m:task create "inline folder browser" --type feature --priority high --mobile
```

### Testing
```bash
/m:test --type all
```

## Protection Mechanism

### Why `/m/` subdirectory?
- SuperClaude installs default commands to `/home/node/.claude/commands/`
- Your custom commands go to `/home/node/.claude/commands/m/`
- SuperClaude updates won't touch the `/m/` subdirectory

### Rebuild Process
1. SuperClaude Framework installed via pipx
2. SuperClaude's default commands installed
3. Your custom commands copied to `/m/` subdirectory
4. Both sets of commands available simultaneously

## Maintenance

### Adding New Custom Commands
1. Create new `.md` file in `/workspace/.claude/commands/m/`
2. Follow the YAML frontmatter format (see existing files)
3. Rebuild container to deploy

### Updating Existing Commands
1. Edit files in `/workspace/.claude/commands/m/`
2. Rebuild container or copy manually:
   ```bash
   cp /workspace/.claude/commands/m/*.md /home/node/.claude/commands/m/
   ```

### Backup Strategy
Your commands are:
- ✅ Version controlled in `/workspace/.claude/`
- ✅ Backed up with your project repository
- ✅ Isolated from SuperClaude updates
- ✅ Automatically deployed during container rebuild

## Command Format

All custom commands follow the SuperClaude Framework format:

```markdown
---
name: command-name
description: "Brief description"
category: moodle|utility|workflow
complexity: basic|intermediate|advanced
mcp-servers: [sequential, context7, serena]
personas: [architect, backend, qa-specialist]
---

# /m:command-name - Full Title

## Triggers
[When to use this command]

## Usage
```
/m:command-name [args] [--flags]
```

## Behavioral Flow
[How the command works]

## Examples
[Usage examples]

## Boundaries
[What the command will/won't do]
```

## Integration with SuperClaude

Your custom Moodle commands work **alongside** SuperClaude's default commands:

- **SuperClaude defaults**: General-purpose commands
- **Your `/m:` commands**: Moodle-specific workflows

Both are available simultaneously, giving you the best of both worlds!

## DO NOT MODIFY
This protection strategy is critical. Do not:
- ❌ Move commands out of `/m/` subdirectory
- ❌ Rename the `/m/` directory
- ❌ Manually edit commands in `/home/node/.claude/` (edit in `/workspace/.claude/` instead)
- ❌ Delete the COPY instruction from Dockerfile

## Version History
- **v1.0** (2025-10-26): Initial protection strategy implementation
- Added automatic copy during container build
- Created protection documentation
