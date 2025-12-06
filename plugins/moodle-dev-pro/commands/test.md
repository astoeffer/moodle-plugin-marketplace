---
name: test
description: "Moodle plugin testing with PHPUnit, Behat, code standards, and pre-release validation"
category: utility
complexity: enhanced
mcp-servers: [playwright]
personas: [qa-specialist]
---

# /sc:test - Moodle Plugin Testing Suite

## Triggers
- PHPUnit test execution for unit and integration tests
- Behat acceptance testing for user interactions
- Moodle code standards validation (PSR-12 with exceptions)
- Pre-release testing checklist execution
- Mobile app compatibility verification

## Usage
```
/sc:test [target] [--type phpunit|behat|standards|mobile|all] [--coverage] [--fix] [--release]
```

## Behavioral Flow
1. **Analyze**: Check plugin structure and test availability
2. **Validate**: Run code standards checks (phpcs, phpcbf)
3. **Execute**: Run PHPUnit tests with coverage analysis
4. **Acceptance**: Execute Behat scenarios for UI testing
5. **Report**: Generate comprehensive test results and metrics

Key behaviors:
- Execute PHPUnit tests in `/tests/` directory
- Run Behat features in `/tests/behat/`
- Validate PSR-12 compliance with Moodle exceptions
- Test OAuth2 and shared link authentication methods
- Verify mobile app compatibility

## Moodle Test Environment
```bash
# Test instance configuration
MOODLE_URL=https://your-test-instance.com
MOODLE_VERSION=4.5
PHP_VERSION=8.1
DB_TYPE=mariadb
```

## Test Types

### 1. Code Standards (`--type standards`)
```bash
# PSR-12 with Moodle exceptions
phpcs --standard=PSR12 mod/nextcloudfolder/
phpcbf --standard=PSR12 mod/nextcloudfolder/

# Moodle-specific checks
php admin/cli/check_database_schema.php
php admin/cli/check_lang_strings.php
```

### 2. PHPUnit Tests (`--type phpunit`)
```bash
# Initialize PHPUnit
php admin/tool/phpunit/cli/init.php

# Run plugin tests
vendor/bin/phpunit mod/nextcloudfolder/tests/

# With coverage
vendor/bin/phpunit --coverage-html coverage/ mod/nextcloudfolder/tests/
```

### 3. Behat Tests (`--type behat`)
```bash
# Initialize Behat
php admin/tool/behat/cli/init.php

# Run plugin features
vendor/bin/behat --tags @mod_nextcloudfolder

# Specific scenarios
vendor/bin/behat --tags @mod_nextcloudfolder_oauth2
vendor/bin/behat --tags @mod_nextcloudfolder_sharelink
```

### 4. Mobile Compatibility (`--type mobile`)
```bash
# Test web services
php admin/cli/webservice_test.php --protocol=rest --function=mod_nextcloudfolder_get_folder

# Verify mobile handlers
php admin/cli/cfg.php --name=enablemobilewebservice --set=1
```

## Pre-Release Checklist (`--release`)

### Automated Tests
- [ ] PHPUnit: All tests passing
- [ ] Behat: All scenarios green
- [ ] Code standards: PSR-12 compliant
- [ ] No PHP errors/warnings
- [ ] JavaScript AMD modules compiled

### Manual Testing Matrix
| Feature | OAuth2 | Shared Link | Mobile |
|---------|--------|-------------|--------|
| View folder | ✓ | ✓ | ✓ |
| Download file | ✓ | ✓ | ✓ |
| Browse subfolders | ✓ | ✓ | ✓ |
| Tree/Table view | ✓ | ✓ | ✓ |
| Inline display | ✓ | ✓ | ✓ |
| Download ZIP | ✓ | ✓ | ✓ |

### Security Validation
- [ ] SQL injection tests
- [ ] XSS prevention verified
- [ ] CSRF protection active
- [ ] Capability checks enforced
- [ ] Input sanitization complete

### Performance Testing
- [ ] Cache functionality working
- [ ] Large folder handling (1000+ files)
- [ ] Concurrent user access
- [ ] Memory usage acceptable

## MCP Integration
- **Playwright MCP**: Browser automation for Behat visual tests
- **QA Specialist Persona**: Test analysis and quality metrics
- **Sequential MCP**: Multi-file test execution coordination

## Tool Coordination
- **dev.sh**: Helper script for Moodle test commands
- **Bash**: Test runner execution
- **Grep**: Test result parsing
- **TodoWrite**: Track test failures and fixes
- **Write**: Generate test reports

## Examples

### Standard Test Suite
```
/sc:test --type all
# Runs complete test suite:
# 1. Code standards check
# 2. PHPUnit with coverage
# 3. Behat acceptance tests
# 4. Mobile compatibility check
```

### Quick Validation
```
/sc:test --type standards --fix
# Check and auto-fix code standards
./dev.sh check
./dev.sh fix
```

### Pre-Release Testing
```
/sc:test --release
# Complete pre-release checklist:
# - All automated tests
# - Generate coverage report
# - Security validation
# - Performance benchmarks
# - Mobile app verification
```

### OAuth2 Integration Test
```
/sc:test tests/oauth2_test.php --type phpunit
# Test OAuth2 authentication flow
# Verify token refresh
# Check permission handling
```

### Shared Link Test
```
/sc:test --type behat --tags @sharelink
# Test public folder access
# Verify file browsing
# Check download functionality
```

## Test Output Examples

### PHPUnit Success
```
PHPUnit 9.5.10 by Sebastian Bergmann.

...............................................  47 / 47 (100%)

Time: 00:02.341, Memory: 24.00 MB

OK (47 tests, 182 assertions)

Code Coverage: 85.3%
```

### Behat Features
```
Feature: Nextcloud folder browsing
  Scenario: Browse shared folder          # Passed
  Scenario: Download file from folder     # Passed
  Scenario: Switch between view modes     # Passed
  
3 scenarios (3 passed)
15 steps (15 passed)
```

## Boundaries

**Will:**
- Execute Moodle-specific test suites (PHPUnit, Behat)
- Validate PSR-12 compliance with Moodle exceptions
- Test both OAuth2 and shared link authentication
- Verify mobile app compatibility
- Generate comprehensive test reports

**Will Not:**
- Modify production database during tests
- Execute tests without proper Moodle test environment
- Skip security validation checks
- Ignore Moodle coding standards