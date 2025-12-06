---
name: git
description: "Git operations with Moodle plugin development workflow and intelligent commit messages"
category: utility
complexity: basic
mcp-servers: []
personas: []
---

# /sc:git - Moodle Plugin Git Workflow

## Triggers
- Git repository operations for Moodle plugin development
- Feature branch creation following Git Flow model
- Conventional commit message generation for Moodle tracker
- Release management and version tagging
- Hotfix and support branch management

## Usage
```
/sc:git [operation] [args] [--smart-commit] [--moodle-tracker MDL-XXXXX]
```

## Behavioral Flow
1. **Analyze**: Check repository state and current branch context
2. **Validate**: Ensure operation follows Git Flow branching model
3. **Execute**: Run Git command with Moodle-specific conventions
4. **Optimize**: Apply MDL tracker references and conventional commits
5. **Report**: Provide status with next steps per workflow

Key behaviors:
- Follow Git Flow model: main, develop, feature/*, release/*, hotfix/*
- Generate Moodle-compliant commit messages (MDL-XXXXX format)
- Apply branch naming: feature/issue-{number}-{description}
- Update version.php and CHANGELOG.md for releases
- Enforce PR workflow to develop branch (never direct to main)

## Tool Coordination
- **Bash**: Git command execution and repository operations
- **Read**: Repository state, version.php, and CHANGELOG.md analysis
- **Edit**: Update version.php and documentation files
- **Grep**: Log parsing and MDL tracker reference validation

## Key Patterns
- **Feature Development**: develop → feature/issue-XX → PR to develop
- **Release Process**: develop → release/X.Y.Z → main + tag + back to develop
- **Hotfix Flow**: main → hotfix/X.Y.Z → main + tag + develop
- **Commit Convention**: `<type>(<scope>): <subject> (#issue)` or `MDL-XXXXX mod_nextcloudfolder: <description>`

## Moodle-Specific Workflows

### Start New Feature
```
/sc:git feature issue-53-subfolder-browse
# Creates feature/issue-53-subfolder-browse from develop
# Sets up tracking and provides commit message template
```

### Smart Moodle Commit
```
/sc:git commit --moodle-tracker MDL-12345
# Generates: "MDL-12345 mod_nextcloudfolder: <analyzed changes>"
# Or conventional: "feat(oauth2): Add subfolder browsing (#53)"
```

### Create Release
```
/sc:git release 2.1.0
# Creates release/2.1.0 from develop
# Updates version.php with YYYYMMDDXX format
# Prepares CHANGELOG.md entry
# Guides through merge to main and develop
```

### Emergency Hotfix
```
/sc:git hotfix 2.0.1
# Creates hotfix/2.0.1 from main
# Updates version.php and CHANGELOG.md
# Manages merge to both main and develop
```

## Commit Message Types
- `feat`: New feature (backward compatible)
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code formatting (PSR-12 compliance)
- `refactor`: Code restructuring
- `test`: PHPUnit or Behat tests
- `chore`: Version bumps, dependencies

## Version Management
Following Semantic Versioning and Moodle conventions:
- **version.php**: YYYYMMDDXX format (e.g., 2024010100)
- **Git tags**: vX.Y.Z format (e.g., v2.1.0)
- **MAJOR.MINOR.PATCH**: Breaking.Feature.Bugfix

## Examples

### Feature Development
```
/sc:git feature issue-47-oauth-fixes
# Switches to develop, pulls latest, creates feature branch
# Provides template: "feat(oauth2): <description> (#47)"
```

### Moodle Tracker Commit
```
/sc:git commit --moodle-tracker MDL-78901
# Analyzes changes and generates:
# "MDL-78901 mod_nextcloudfolder: Fix OAuth2 token refresh"
```

### Release Preparation
```
/sc:git release 2.2.0
# 1. Creates release/2.2.0 from develop
# 2. Updates version.php: $plugin->version = 2024011500
# 3. Updates CHANGELOG.md with version entry
# 4. Guides merge to main with tag v2.2.0
# 5. Ensures backmerge to develop
```

## Boundaries

**Will:**
- Follow Git Flow branching model strictly
- Generate Moodle-compliant commit messages
- Manage version.php and CHANGELOG.md updates
- Enforce PR workflow (no direct commits to main)
- Create appropriate tags for releases

**Will Not:**
- Bypass PR review requirements on protected branches
- Delete main or develop branches
- Force push without explicit confirmation
- Modify .git configuration without authorization