---
name: troubleshoot
description: "Diagnose and resolve Moodle plugin issues with GitHub issue tracking integration"
category: moodle
complexity: intermediate
mcp-servers: []
personas: []
---

# /sc:troubleshoot - Moodle Issue Diagnosis and Resolution

## Triggers
- Moodle plugin errors and runtime exceptions
- Nextcloud connectivity and OAuth2 authentication issues
- PHPUnit/Behat test failures and environment issues
- Database migration and upgrade problems
- Code standards violations and syntax errors
- Performance degradation and memory issues

## Usage
```
/sc:troubleshoot [issue] [--type error|test|db|oauth|perf] [--create-issue] [--search-issues]
```

## Behavioral Flow
1. **Search Existing Issues**: Check GitHub for similar reported issues
2. **Analyze**: Examine error logs, debug output, and system state
3. **Diagnose**: Identify root cause through systematic investigation
4. **Document**: Create/update GitHub issue with findings
5. **Resolve**: Apply fix and verify resolution
6. **Track**: Update issue status and document solution

Key behaviors:
- GitHub issue integration for knowledge sharing
- Moodle-specific debugging with error_log and debugging functions
- Test environment validation (PHPUnit/Behat)
- OAuth2/Nextcloud connectivity diagnosis
- Database state verification

## Tool Coordination
- **Bash**: Execute diagnostic commands (php, mysql, curl)
- **Read**: Examine error logs (/workspace/moodledata/error.log)
- **Grep**: Search for error patterns in code and logs
- **GitHub CLI**: Search/create/update issues
- **WebFetch**: Check Moodle documentation for known issues
- **TodoWrite**: Track resolution steps

## GitHub Issue Integration

### Search Existing Issues
```bash
# Search for similar issues
gh issue list --repo astoeffer/Moodle-Nextcloud-Folder-Plugin --search "nextcloud connection"
gh issue view <number> --comments  # View detailed discussion
```

### Create New Issue
```bash
# Create issue with diagnostic data
gh issue create --repo astoeffer/Moodle-Nextcloud-Folder-Plugin \
  --title "Error: Could not connect to Nextcloud" \
  --label "bug,oauth2" \
  --body "$(cat issue_template.md)"
```

## Common Moodle Issues

### Nextcloud Connection Error
```
"Could not connect to Nextcloud. Please check your internet connection and try again."
```
**Diagnosis Steps:**
1. Check OAuth2 issuer configuration in database
2. Verify network connectivity from container
3. Check Nextcloud server logs
4. Validate SSL certificates
5. Test with curl directly

### PHPUnit Environment Issues
```
"Moodle PHPUnit environment was initialised for different version"
```
**Resolution:**
1. Drop all phpu_* tables
2. Clear phpunitdata directory
3. Reinitialize with admin/tool/phpunit/cli/init.php

### Database Version Mismatch
```
"Plugin version in database doesn't match version.php"
```
**Resolution:**
1. Check mdl_config_plugins table
2. Update version to match version.php
3. Run admin/cli/upgrade.php

## Key Patterns

### Error Analysis Pattern
```
/sc:troubleshoot "Could not connect to Nextcloud" --search-issues
# 1. Search GitHub for similar issues
# 2. Check error logs and debug output
# 3. Test connectivity with curl
# 4. Verify OAuth2 configuration
# 5. Create/update GitHub issue with findings
```

### Test Failure Pattern
```
/sc:troubleshoot "PHPUnit test failures" --type test
# 1. Check test environment initialization
# 2. Verify database prefix configuration
# 3. Examine specific test errors
# 4. Check for missing mock objects
# 5. Document in GitHub issue
```

### Performance Issue Pattern
```
/sc:troubleshoot "Slow folder browsing" --type perf --create-issue
# 1. Enable Moodle performance debugging
# 2. Check database query times
# 3. Analyze WebDAV response times
# 4. Profile PHP execution
# 5. Create issue with metrics
```

## Moodle-Specific Debugging

### Enable Debug Output
```php
// In config.php
$CFG->debug = (E_ALL | E_STRICT);
$CFG->debugdisplay = 1;
$CFG->debugsmtp = true;
$CFG->perfdebug = 15;
$CFG->debugpageinfo = 1;
```

### Check Error Logs
```bash
# Moodle error log
tail -f /workspace/moodledata/error.log

# PHP error log
tail -f /var/log/php_errors.log

# Apache/Nginx logs
tail -f /var/log/apache2/error.log
```

### Database Debugging
```sql
-- Check plugin version
SELECT * FROM mdl_config_plugins WHERE plugin = 'nextcloudfolder';

-- Check OAuth2 issuers
SELECT * FROM mdl_oauth2_issuer;

-- Check recent errors
SELECT * FROM mdl_logstore_standard_log 
WHERE timecreated > UNIX_TIMESTAMP(NOW() - INTERVAL 1 HOUR)
AND component = 'mod_nextcloudfolder';
```

## Issue Template Format

When creating GitHub issues, use this template:

```markdown
## Environment
- Moodle Version: 4.5.6
- Plugin Version: 2.0.0
- PHP Version: 8.1
- Database: MariaDB 10.6
- Container: Yes/No

## Issue Description
[Clear description of the problem]

## Error Message
```
[Exact error message]
```

## Steps to Reproduce
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Diagnostic Information
### Error Logs
```
[Relevant log entries]
```

### Debug Output
```
[Debug information]
```

### Network Tests
```
[curl/ping results if connectivity issue]
```

## Expected Behavior
[What should happen]

## Actual Behavior
[What actually happens]

## Attempted Solutions
- [ ] Solution 1
- [ ] Solution 2

## Additional Context
[Any other relevant information]
```

## Examples

### OAuth2 Connection Issue
```
/sc:troubleshoot "Could not connect to Nextcloud" --search-issues --create-issue
# Searches existing issues for "nextcloud connection"
# Runs connectivity tests
# Creates detailed GitHub issue with diagnostics
```

### Test Environment Issue
```
/sc:troubleshoot "PHPUnit initialization failed" --type test
# Checks database tables and data directories
# Verifies config.php settings
# Documents solution in existing or new issue
```

### Database Migration Issue
```
/sc:troubleshoot "Upgrade blocked by version mismatch" --type db --create-issue
# Checks version in database vs version.php
# Provides SQL fix commands
# Creates issue for tracking
```

## Boundaries

**Will:**
- Search and reference existing GitHub issues
- Create detailed issue reports with diagnostics
- Execute Moodle-specific debugging procedures
- Track resolution steps in GitHub
- Verify fixes against test suites

**Will Not:**
- Modify production databases without backup
- Apply untested fixes to live systems
- Close GitHub issues without verification
- Skip issue documentation for recurring problems
- Ignore existing solutions in issue history

## Integration with Other Commands

- **/sc:test**: Run tests after applying fixes
- **/sc:git**: Commit fixes and reference issue numbers
- **/sc:implement**: Implement permanent solutions for issues
- **/sc:clean**: Clean up after troubleshooting sessions

## Best Practices

1. **Always search existing issues first** - Avoid duplicate reports
2. **Include full diagnostic data** - Help future troubleshooting
3. **Reference issue numbers in commits** - Link fixes to problems
4. **Update issues with solutions** - Build knowledge base
5. **Tag issues appropriately** - Enable better searching
6. **Test fixes thoroughly** - Prevent regression
7. **Document workarounds** - Help users until permanent fix