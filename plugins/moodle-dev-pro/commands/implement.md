---
name: implement
description: "Moodle plugin feature implementation with PSR-12 compliance and framework standards"
category: workflow
complexity: standard
mcp-servers: [context7, sequential, magic, playwright]
personas: [architect, frontend, backend, security, qa-specialist]
---

# /sc:implement - Moodle Plugin Implementation

## Triggers
- Moodle plugin feature development (activities, blocks, local plugins)
- Code refactoring for PSR-12 and Moodle coding standards compliance
- Web service implementation for mobile app compatibility
- Database schema changes with XMLDB
- AMD module development for JavaScript functionality

## Usage
```
/sc:implement [feature-description] [--type activity|block|local|webservice|amd] [--refactor] [--psr12-check] [--with-tests]
```

## Behavioral Flow
1. **Analyze**: Check current code against Moodle standards (PSR-12 with exceptions)
2. **Plan**: Reference `/workspace/moodle/mod/nextcloudfolder/DEVELOPMENT.md` for guidelines
3. **Implement**: Apply Moodle-specific patterns (lowercase_with_underscores, frankenstyle)
4. **Validate**: Run phpcs with Moodle standard, check capabilities and security
5. **Test**: Generate PHPUnit/Behat tests, verify mobile compatibility

Key behaviors:
- PSR-12 compliance with Moodle-specific exceptions (see DEVELOPMENT.md)
- Frankenstyle naming conventions (mod_nextcloudfolder_*)
- Security validation (require_login, capability checks, input sanitization)
- Mobile app compatibility through Web Services API

## Moodle Standards Reference
See `/workspace/moodle/mod/nextcloudfolder/DEVELOPMENT.md` for:
- PSR-12 rules and Moodle exceptions
- Security best practices
- Database operations with XMLDB
- Web services implementation
- Mobile app development guidelines

## MCP Integration
- **Context7 MCP**: Moodle API documentation and coding standards
- **Magic MCP**: Mustache template generation and UI components
- **Sequential MCP**: Complex refactoring and multi-file updates
- **Playwright MCP**: Behat test validation and browser testing

## Tool Coordination
- **dev.sh**: Helper script for common Moodle tasks (cache purge, code check)
- **Write/Edit/MultiEdit**: Code generation following Moodle patterns
- **Read/Grep/Glob**: Analyze existing code for refactoring needs
- **TodoWrite**: Track refactoring progress across multiple files
- **Bash**: Execute phpcs, phpcbf, and PHPUnit commands

## Key Patterns
- **Naming Convention**: `class some_custom_class`, `function get_user_data()`
- **File Structure**: `/classes/`, `/db/`, `/lang/en/`, `/templates/`
- **Security Flow**: require_login → capability check → input validation → output escaping
- **Database Pattern**: XMLDB schema → DML functions → upgrade.php
- **Mobile Pattern**: Web Service → Mobile handler → Mustache template

## Examples

### Refactor for PSR-12 Compliance
```
/sc:implement refactor all PHP files --refactor --psr12-check
# Analyzes code against Moodle standards
# Applies PSR-12 with Moodle exceptions
# Updates to lowercase_with_underscores naming
```

### Web Service Implementation
```
/sc:implement folder browsing API --type webservice --with-tests
# Creates classes/external/browse_folders.php
# Updates db/services.php
# Generates mobile-compatible output format
```

### Activity Module Feature
```
/sc:implement OAuth2 authentication --type activity
# Implements in lib.php with nextcloudfolder_ prefix
# Adds capabilities to db/access.php
# Creates language strings in lang/en/
```

### AMD Module Development
```
/sc:implement file browser UI --type amd
# Creates amd/src/filebrowser.js with ES6
# Builds with grunt amd
# Integrates with Mustache templates
```

### Database Schema Update
```
/sc:implement add sharing permissions --type xmldb
# Updates db/install.xml via XMLDB editor
# Generates db/upgrade.php code
# Bumps version in version.php
```

## Moodle-Specific Validations

### Code Standards Check
```bash
# Run via dev.sh helper
./dev.sh check  # phpcs with Moodle standard
./dev.sh fix    # phpcbf auto-fix

# Or directly
vendor/bin/phpcs --standard=moodle mod/nextcloudfolder/
```

### Security Checklist
- ✓ require_login() called
- ✓ Capabilities checked with require_capability()
- ✓ Input validated with required_param()/optional_param()
- ✓ Output escaped with s(), format_string()
- ✓ SQL uses placeholders
- ✓ Session key verified with require_sesskey()

### Testing Requirements
```bash
# PHPUnit tests
vendor/bin/phpunit mod/nextcloudfolder/tests/

# Behat tests
vendor/bin/behat --tags @mod_nextcloudfolder

# Mobile compatibility
php admin/cli/webservice_test.php
```

## Boundaries

**Will:**
- Implement Moodle plugin features following official standards
- Refactor code for PSR-12 compliance with Moodle exceptions
- Ensure mobile app compatibility and Web Services integration
- Apply security best practices and capability checks

**Will Not:**
- Use camelCase or PascalCase (must use lowercase_with_underscores)
- Skip security validations or capability checks
- Implement without considering mobile app compatibility
- Ignore Moodle's frankenstyle naming conventions