---
description: Purge Moodle caches across all instances or specific versions
allowed-tools: Bash, AskUserQuestion
---

# Moodle Cache Purger

Purge Moodle caches for one or all instances in the development environment.

## Ask the user which instances to purge:

Use AskUserQuestion to ask:
- Question: "Which Moodle instance caches should be purged?"
- MultiSelect: true
- Options:
  1. Moodle 4.1 (port 8041) - PHP 8.1
  2. Moodle DH-Prod (port 8043) - PHP 8.1
  3. Moodle 4.5 (port 8045) - PHP 8.2
  4. Moodle 5.1 (port 8051) - PHP 8.3
  5. All instances

## Cache Purge Commands

### Moodle 4.1
```bash
docker exec moodle-dev php8.1 /opt/moodle-MOODLE_401_STABLE/admin/cli/purge_caches.php
```

### Moodle DH-Prod
```bash
docker exec moodle-dev php8.1 /workspace/moodle-dh-prod/admin/cli/purge_caches.php
```

### Moodle 4.5
```bash
docker exec moodle-dev php8.2 /opt/moodle-MOODLE_405_STABLE/admin/cli/purge_caches.php
```

### Moodle 5.1
```bash
docker exec moodle-dev php8.3 /opt/moodle-MOODLE_501_STABLE/admin/cli/purge_caches.php
```

## Execution Steps

1. **Pre-check**
   - Verify container is running: `docker ps | grep moodle-dev`
   - Verify PHP versions are available

2. **Execute cache purge**
   - Run the appropriate command(s) based on user selection
   - Capture output and any errors

3. **Verify**
   - Check command exit status
   - Report success/failure for each instance

4. **Additional actions** (optional, ask user)
   - Restart PHP-FPM pool after cache purge?
   - Test web access after purge?

## Output Format

```
MOODLE CACHE PURGE
==================

Moodle 4.5:  ✓ Cache purged successfully
Moodle 5.1:  ✓ Cache purged successfully

Time taken:  2.3 seconds
```

## Common Cache Types

Inform user that this purges all caches including:
- Application cache (MUC)
- Theme cache
- Language strings cache
- JavaScript cache
- Template cache

## Troubleshooting

If cache purge fails:
- Check PHP-FPM service status
- Verify Moodle directory paths
- Check file permissions on data directories
- Review PHP error logs for details
