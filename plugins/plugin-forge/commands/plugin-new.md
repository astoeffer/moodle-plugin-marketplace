---
name: plugin-new
description: Create a new Claude Code plugin with complete directory structure, manifest, and optional components
argument-hint: [plugin-name] [--with-commands] [--with-agents] [--with-skills] [--with-hooks]
---

# Create New Claude Code Plugin

Create a comprehensive Claude Code plugin structure with best practices.

## Plugin Information

**Plugin name:** $1 (kebab-case, e.g., my-awesome-plugin)

## Components to Include

Review the arguments to determine what components to scaffold:
- Commands: $2 contains `--with-commands`
- Agents: $2 contains `--with-agents`
- Skills: $2 contains `--with-skills`
- Hooks: $2 contains `--with-hooks`

If no flags provided, create interactive wizard asking user what components they need.

## Steps to Execute

1. **Validate Plugin Name**
   - Must be kebab-case (lowercase letters, numbers, hyphens)
   - Maximum 64 characters
   - No special characters except hyphens

2. **Create Directory Structure**
   ```
   $1/
   ├── .claude-plugin/
   │   └── plugin.json
   ├── commands/         (if --with-commands)
   ├── agents/           (if --with-agents)
   ├── skills/           (if --with-skills)
   ├── hooks/            (if --with-hooks)
   │   └── hooks.json
   ├── templates/        (always)
   └── README.md         (always)
   ```

3. **Generate plugin.json**
   Ask user for:
   - Description (required, max 1024 chars)
   - Author name and email (optional)
   - Homepage URL (optional)
   - License (default: MIT)
   - Keywords (comma-separated)

   Template:
   ```json
   {
     "name": "$1",
     "version": "1.0.0",
     "description": "<user-provided>",
     "author": {
       "name": "<user-provided>",
       "email": "<user-provided>"
     },
     "homepage": "<user-provided>",
     "repository": "<user-provided>",
     "license": "MIT",
     "keywords": [],
     "commands": "./commands",
     "agents": "./agents",
     "skills": "./skills",
     "hooks": "./hooks/hooks.json"
   }
   ```

4. **Create Sample Components**

   **If --with-commands:** Create `commands/example.md`:
   ```markdown
   ---
   name: example
   description: Example command demonstrating argument handling
   argument-hint: [arg1] [arg2]
   ---

   # Example Command

   This is an example command for your plugin.

   ## Arguments
   - First argument: $1
   - Second argument: $2
   - All arguments: $ARGUMENTS

   Replace this with your actual command logic.
   ```

   **If --with-agents:** Create `agents/example-agent.md`:
   ```markdown
   ---
   name: example-agent
   description: Example agent demonstrating specialized capabilities
   tools: Read, Write, Bash
   model: sonnet
   ---

   # Example Agent

   You are an expert assistant specializing in [domain].

   ## Core Expertise
   - Skill 1
   - Skill 2

   ## Tool Usage
   - Read: Analyze files
   - Write: Create new files
   - Bash: Execute commands
   ```

   **If --with-skills:** Create `skills/example-skill/SKILL.md`:
   ```markdown
   ---
   name: example-skill
   description: Example skill that activates automatically when [condition]. Use when working with [context].
   allowed-tools: Read, Grep
   ---

   # Example Skill

   ## Automatic Activation
   This skill activates when:
   - User mentions specific keywords
   - Working with certain file types
   - Specific context detected

   ## Actions
   1. Analyze the situation
   2. Perform validation
   3. Provide feedback
   ```

   **If --with-hooks:** Create `hooks/hooks.json`:
   ```json
   {
     "SessionStart": [
       {
         "matcher": "*",
         "hooks": [
           {
             "type": "command",
             "command": "#!/bin/bash\\necho '$1 Plugin Loaded'\\nexit 0\\n",
             "timeout": 5000
           }
         ]
       }
     ]
   }
   ```

5. **Generate README.md**
   Include:
   - Plugin name and description
   - Installation instructions
   - Component listing
   - Usage examples
   - Configuration options
   - Development guidelines

6. **Initialize Git Repository** (optional, ask user)
   ```bash
   cd $1
   git init
   git add .
   git commit -m "Initial commit: $1 plugin scaffold"
   ```

7. **Display Summary**
   ```
   ✅ Plugin Created: $1

   Directory Structure:
   - plugin.json manifest configured
   - [X] commands/ with example command
   - [X] agents/ with example agent
   - [X] skills/ with example skill
   - [X] hooks/ with session start hook
   - ✓ templates/ directory
   - ✓ README.md documentation

   Next Steps:
   1. cd $1
   2. Edit .claude-plugin/plugin.json (customize metadata)
   3. Replace example components with your logic
   4. Test locally: claude plugin install ./$1
   5. Validate: /plugin-validate

   Documentation:
   - Commands: https://code.claude.com/docs/en/slash-commands
   - Agents: https://code.claude.com/docs/en/sub-agents
   - Skills: https://code.claude.com/docs/en/skills
   - Hooks: https://code.claude.com/docs/en/hooks
   ```

## Validation

Before completion:
- ✓ Plugin name is valid (kebab-case)
- ✓ plugin.json has required fields
- ✓ Directory structure is correct
- ✓ Sample components are properly formatted
- ✓ README.md is comprehensive

## Error Handling

- If plugin directory already exists: Ask to overwrite or choose new name
- If invalid plugin name: Suggest corrections
- If missing required info: Prompt user with clear questions
