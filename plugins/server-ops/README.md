# Server Ops Plugin

Production-grade server administration, Docker automation, and monitoring plugin for multi-version Moodle development environments.

## Overview

This plugin provides specialized expertise for managing complex DevContainer environments with multiple Moodle versions, PHP-FPM pools, Nginx virtual hosts, and MariaDB databases.

## Features

### 🤖 Agent: server-admin
Expert agent for server administration and DevOps tasks.

**Capabilities:**
- Docker container orchestration and troubleshooting
- PHP-FPM multi-version pool management
- Nginx configuration and optimization
- MariaDB database administration
- Service monitoring and log analysis
- Moodle CLI operations across versions
- Automated deployment and maintenance
- Security hardening and compliance

**Use proactively for:**
- Container startup issues
- Service configuration changes
- Performance troubleshooting
- Automated maintenance tasks
- Infrastructure monitoring

### 📋 Commands

#### `/monitor`
Comprehensive health check for all services.

**Checks:**
- Container status (docker ps)
- Service health (nginx, PHP-FPM pools)
- Database connectivity
- Web endpoint availability
- System resources (disk, memory)
- Recent errors in logs

**Usage:**
```
/monitor
```

#### `/logs`
Interactive log viewer with filtering.

**Features:**
- Access Nginx, PHP-FPM, Moodle, Docker logs
- Filter by time range or pattern
- Follow mode (tail -f)
- Aggregate error view across services

**Usage:**
```
/logs
```

#### `/moodle-cache`
Purge Moodle caches across instances.

**Features:**
- Purge individual or all Moodle instances
- Version-specific PHP execution
- Verification and reporting
- Optional service restart

**Usage:**
```
/moodle-cache
```

### 🎓 Skill: defensive-bash
Production-grade defensive Bash scripting patterns.

**Topics:**
- Script safety headers (`set -euo pipefail`)
- Error handling and logging
- Input validation
- Idempotent operations
- Signal handling and cleanup
- Locking mechanisms
- Docker-specific patterns
- Moodle CLI automation

**Use for:**
- Writing automation scripts
- Refactoring existing scripts
- Code review and security hardening
- Learning best practices

## Installation

The plugin is already installed at `~/.claude/plugins/local/server-ops/`.

**Enable in settings.json:**
```json
{
  "enabledPlugins": {
    "server-ops@local": true
  }
}
```

**Verify:**
```
/plugin
```

## Environment

This plugin is designed for the specific multi-version Moodle environment:

| Version | Port | PHP | Database | Socket |
|---------|------|-----|----------|--------|
| 4.1 | 8041 | 8.1 | moodle41 | php8.1-fpm-41.sock |
| DH-Prod | 8043 | 8.1 | moodle_dh_prod | php8.1-fpm-dh-prod.sock |
| 4.5 | 8045 | 8.2 | moodle45 | php8.2-fpm-45.sock |
| 5.1 | 8051 | 8.3 | moodle51 | php8.3-fpm-51.sock |

**Containers:**
- `moodle-dev` - Main DevContainer
- `moodle-dev-db` - MariaDB 10.11
- `moodle-dev-mailpit` - Email testing

## Usage Examples

### Quick Health Check
```
User: /monitor
```
Gets comprehensive status of all services and resources.

### View Recent Errors
```
User: /logs
Assistant: Which logs would you like to view?
User: [selects "All recent errors"]
```

### Purge All Caches
```
User: /moodle-cache
Assistant: Which instances?
User: [selects "All instances"]
```

### Delegate to Server Admin Agent
```
User: The PHP-FPM pool for Moodle 4.5 is not starting. Help me troubleshoot.
Claude: [Activates server-admin agent]
Agent: Investigates logs, checks configuration, suggests fixes
```

### Write Automation Script
```
User: Help me write a script to backup all Moodle databases nightly
Claude: [Uses defensive-bash skill]
Claude: [Creates production-grade script with error handling, logging, locking]
```

## Common Operations

### Container Restart
```
# Via VSCode (recommended)
VSCode → "Dev Containers: Reopen in Container"

# Check status
docker ps
```

### Service Management
```bash
# Restart PHP-FPM
docker exec moodle-dev sudo systemctl restart php8.2-fpm

# Reload Nginx
docker exec moodle-dev nginx -t
docker exec moodle-dev sudo systemctl reload nginx
```

### Moodle CLI
```bash
# Purge cache (version-specific)
docker exec moodle-dev php8.2 /opt/moodle-MOODLE_405_STABLE/admin/cli/purge_caches.php

# Run upgrade
docker exec moodle-dev php8.2 /opt/moodle-MOODLE_405_STABLE/admin/cli/upgrade.php --non-interactive
```

### Database Access
```bash
# Connect to database
docker exec moodle-dev mysql -h db -u moodleuser -pm@0dl3ing

# Backup database
docker exec moodle-dev-db mysqldump -u root -p'<ROOT_PASS>' moodle45 > backup.sql
```

## Integration with Other Plugins

**Works well with:**
- `moodle-dev-pro` - Moodle plugin development
- `shell-scripting:bash-pro` - Advanced bash patterns
- `security-scanning` - Security audits

## Contributing

To extend this plugin:

1. **Add new commands:** Create `.md` files in `commands/`
2. **Enhance agent:** Edit `agents/server-admin.md`
3. **Add skills:** Create new `.md` files in `skills/`
4. **Test thoroughly** in the development environment

## License

MIT

## Author

Andreas Stöffer <andreas@learnforge.de>

---

**Version:** 1.0.0
**Status:** Production Ready
**Last Updated:** 2025-11-16
