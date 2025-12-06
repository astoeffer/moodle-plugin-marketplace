---
name: task
description: "Execute complex Moodle plugin tasks with intelligent workflow management"
category: moodle
complexity: advanced
mcp-servers: [sequential, context7, serena]
personas: [architect, backend, security, mobile, accessibility]
---

# /m:task - Moodle Plugin Task Management

## Triggers

- Complex Moodle plugin features requiring multi-component coordination
- Activity module development with database, capability, and UI integration
- Web Services API implementation for mobile app compatibility
- Cross-cutting concerns (security, performance, accessibility, GDPR compliance)
- Upgrade path implementation and version migration tasks

## Usage

```
/m:task [action] [target] [--type feature|bugfix|refactor|upgrade] [--priority high|medium|low] [--mobile]
```

## Behavioral Flow

1. **Analyze**: Parse Moodle-specific requirements and plugin architecture needs
2. **Plan**: Create hierarchical breakdown following Moodle development patterns
3. **Coordinate**: Execute with Moodle coding standards and frankenstyle naming
4. **Validate**: Run Moodle code checker, PHPUnit, Behat tests
5. **Document**: Update version.php, upgrade.php, and CHANGELOG.md

Key behaviors:

- Moodle plugin architecture patterns (mod*\*, block*_, local\__)
- Capability-based security model enforcement
- Mobile app compatibility verification
- XMLDB schema management and upgrade paths
- Frankenstyle naming convention compliance

## MCP Integration

- **Sequential MCP**: Complex upgrade path analysis and dependency resolution
- **Context7 MCP**: Moodle API documentation and best practices
- **Serena MCP**: Cross-session persistence for long-running plugin development

## Tool Coordination

- **TodoWrite**: Moodle task hierarchy (Feature → Component → Implementation)
- **Read/Write/Edit**: Plugin file management following Moodle structure
- **Bash**: PHPUnit, Behat, code checker execution
- **Grep**: Find Moodle API usage patterns and dependencies

## Moodle Task Hierarchy

### Epic Level (Plugin Feature)

```
📋 Feature: OAuth2 Inline Folder Browser
├── 🏗️ Architecture: Component design and integration
├── 🔒 Security: Capability and context validation
├── 💾 Database: XMLDB schema updates
├── 🌐 Web Services: Mobile API endpoints
└── ✅ Testing: PHPUnit and Behat coverage
```

### Story Level (Components)

```
📦 Component: Folder Browser UI
├── AMD modules (JavaScript)
├── Mustache templates
├── Language strings
├── CSS/SCSS styling
└── Accessibility compliance
```

### Task Level (Implementation)

```
✓ Create inline_browser.mustache template
✓ Refactor folderbrowser.js to remove modal
✓ Add view switcher functionality
✓ Implement context menu system
✓ Update language strings in lang/en/
```

## Key Patterns

### Version Management

```php
// version.php updates
$plugin->version = 2024010100; // YYYYMMDDXX format
$plugin->requires = 2022112800; // Moodle 4.1+
$plugin->component = 'mod_nextcloudfolder';
$plugin->maturity = MATURITY_STABLE;
$plugin->release = 'v2.1.0';
```

### Upgrade Path

```php
// db/upgrade.php pattern
function xmldb_nextcloudfolder_upgrade($oldversion) {
    global $DB;
    $dbman = $DB->get_manager();

    if ($oldversion < 2024010100) {
        // Add new table or field
        $table = new xmldb_table('nextcloudfolder_views');
        // ... define structure
        $dbman->create_table($table);

        upgrade_mod_savepoint(true, 2024010100, 'nextcloudfolder');
    }
}
```

### Capability Definition

```php
// db/access.php pattern
$capabilities = [
    'mod/nextcloudfolder:viewfolder' => [
        'captype' => 'read',
        'contextlevel' => CONTEXT_MODULE,
        'archetypes' => [
            'student' => CAP_ALLOW,
            'teacher' => CAP_ALLOW,
        ],
    ],
];
```

### Web Services Implementation

```php
// classes/external.php pattern
class external extends external_api {
    public static function get_folders_parameters() {
        return new external_function_parameters([
            'cmid' => new external_value(PARAM_INT, 'Course module ID'),
        ]);
    }
}
```

## Examples

### Feature Development Task

```
/m:task create "inline folder browser" --type feature --priority high --mobile
# Creates comprehensive task breakdown:
# - Database schema updates
# - AMD module refactoring
# - Template creation
# - Mobile API endpoints
# - Test coverage
```

### Bug Fix Task

```
/m:task fix "OAuth token refresh failure" --type bugfix --priority high
# Systematic bug resolution:
# - Root cause analysis
# - Fix implementation
# - Test case creation
# - Regression testing
```

### Refactoring Task

```
/m:task refactor "PSR-12 compliance" --type refactor --priority medium
# Code quality improvement:
# - PHP CodeSniffer analysis
# - Automated fixing with PHPCBF
# - Manual review for complex cases
# - Verification with Moodle code checker
```

### Upgrade Path Task

```
/m:task upgrade "add view preferences table" --type upgrade --priority medium
# Database migration:
# - XMLDB schema design
# - upgrade.php implementation
# - Data migration logic
# - Rollback considerations
```

## Quality Gates

### Pre-Implementation

- [ ] Moodle version compatibility check
- [ ] Capability requirements defined
- [ ] Database schema designed (XMLDB)
- [ ] Mobile compatibility requirements

### During Implementation

- [ ] Frankenstyle naming compliance
- [ ] Language strings added
- [ ] PHPDoc complete
- [ ] Security checks (PARAM\_\* validation)

### Post-Implementation

- [ ] PHPUnit tests passing
- [ ] Behat tests passing
- [ ] Code checker clean
- [ ] Mobile app tested
- [ ] Accessibility validated (WCAG 2.1 AA)

## Moodle-Specific Validations

### Code Standards

```bash
# Moodle code checker
php admin/cli/check_database_schema.php
vendor/bin/phpcs --standard=moodle mod/nextcloudfolder/
vendor/bin/grunt eslint
```

### Testing

```bash
# PHPUnit
vendor/bin/phpunit mod/nextcloudfolder/tests/

# Behat
vendor/bin/behat --tags @mod_nextcloudfolder

# Mobile testing
php admin/cli/webservice_test.php --function=mod_nextcloudfolder_get_folders
```

### Performance

```bash
# Database queries
grep -r "get_records_sql" mod/nextcloudfolder/
# Check for N+1 queries and missing indexes
```

## Task Persistence

### Session Memory Schema

```
moodle_task_[timestamp]: Task overview and goals
moodle_phase_[1-5]: Major component milestones
moodle_subtask_[x.y]: Implementation details
moodle_tests_[type]: Test execution results
moodle_blockers: Issues requiring resolution
moodle_decisions: Architecture and design choices
```

### Cross-Session Continuity

```
# Session 1: Start feature
write_memory("moodle_task_oauth_inline", "Implement inline folder browser")
write_memory("moodle_phase_1", "UI transformation from modal to inline")

# Session 2: Continue
read_memory("moodle_task_oauth_inline")
think_about_collected_information()
# Resume from phase 1 completion...
```

## Mobile App Considerations

### Mobile Handler Registration

```php
// db/mobile.php
$addons = [
    'mod_nextcloudfolder' => [
        'handlers' => [
            'coursecontent' => [
                'delegate' => 'CoreCourseModuleDelegate',
                'method' => 'mobile_course_view',
                'offlinefunctions' => [],
            ],
        ],
    ],
];
```

### Mobile Output Format

```php
// classes/output/mobile.php
public static function mobile_course_view($args) {
    return [
        'templates' => [
            ['id' => 'main', 'html' => $html],
        ],
        'javascript' => $js,
        'otherdata' => '',
    ];
}
```

## Boundaries

**Will:**

- Execute Moodle plugin development tasks with architectural guidance
- Ensure compliance with Moodle coding standards and conventions
- Implement proper upgrade paths and version management
- Validate mobile app compatibility and accessibility

**Will Not:**

- Modify Moodle core files without explicit permission
- Skip required testing and validation procedures
- Implement features incompatible with target Moodle version
- Bypass security or capability requirements
