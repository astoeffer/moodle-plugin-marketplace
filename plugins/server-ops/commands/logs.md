---
description: Quick access to common logs with filtering options for troubleshooting
allowed-tools: Bash, Grep
---

# Log Viewer

Interactive log viewing and analysis for the Moodle development environment.

## Ask the user which logs to view:

Use the AskUserQuestion tool to ask:
- Question: "Which logs would you like to view?"
- Options:
  1. Nginx access logs (all instances)
  2. Nginx error logs (all instances)
  3. PHP-FPM error logs (all pools)
  4. Moodle debug logs
  5. Docker container logs
  6. Database logs
  7. All recent errors (aggregated)

## Then ask for details:

- Time range: Last 10 lines, 50 lines, 100 lines, or custom
- Filter pattern (optional): Search for specific errors or patterns
- Follow mode: Yes/No (tail -f)

## Log Locations

### Nginx Logs
- Moodle 4.1: `/var/log/nginx/moodle-41-access.log` and `*-error.log`
- DH-Prod: `/var/log/nginx/moodle-dh-prod-access.log` and `*-error.log`
- Moodle 4.5: `/var/log/nginx/moodle-45-access.log` and `*-error.log`
- Moodle 5.1: `/var/log/nginx/moodle-51-access.log` and `*-error.log`

### PHP-FPM Logs
- PHP 8.1: `/var/log/php8.1-fpm.log`
- PHP 8.2: `/var/log/php8.2-fpm.log`
- PHP 8.3: `/var/log/php8.3-fpm.log`

### Moodle Debug Logs
- Check each Moodle's configured log location in config.php

### Container Logs
- `docker logs moodle-dev`
- `docker logs moodle-dev-db`
- `docker logs moodle-dev-mailpit`

## Commands to use:

```bash
# View logs (use docker exec for container logs)
docker exec moodle-dev tail -n 50 /var/log/nginx/moodle-45-error.log

# Follow logs in real-time
docker exec moodle-dev tail -f /var/log/php8.2-fpm.log

# Filter with grep
docker exec moodle-dev tail -n 100 /var/log/nginx/moodle-45-error.log | grep "error"

# Aggregate recent errors
docker exec moodle-dev bash -c "tail -n 20 /var/log/nginx/*-error.log /var/log/php*.log 2>/dev/null | grep -i error"
```

## Output Format

Present logs with:
- Timestamp
- Service/instance name
- Log level (if available)
- Message

Highlight critical errors in red if possible.
Provide context and suggested actions for common errors.
