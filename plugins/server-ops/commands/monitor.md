---
description: Comprehensive health check for all Moodle services, containers, databases, and system resources
allowed-tools: Bash, Grep, Read
---

# System Health Monitor

Perform a comprehensive health check of the multi-version Moodle development environment.

## Check in this order:

1. **Container Status**
   - Run `docker ps` to verify all 3 containers are running
   - Check uptime and restart counts
   - Show container names, ports, and status

2. **Service Status (inside moodle-dev container)**
   - Nginx status: `docker exec moodle-dev sudo systemctl status nginx`
   - PHP-FPM pools: `docker exec moodle-dev sudo systemctl status php8.1-fpm php8.2-fpm php8.3-fpm`
   - Verify all services are active and running

3. **PHP-FPM Sockets**
   - List sockets: `docker exec moodle-dev ls -la /run/php/`
   - Verify all 4 sockets exist:
     - php8.1-fpm-41.sock
     - php8.1-fpm-dh-prod.sock
     - php8.2-fpm-45.sock
     - php8.3-fpm-51.sock

4. **Database Connectivity**
   - Test connection: `docker exec moodle-dev mysql -h db -u moodleuser -pm@0dl3ing -e "SHOW DATABASES;"`
   - Verify all 4 Moodle databases exist
   - Check database server uptime

5. **Web Service Availability**
   - Test each Moodle instance with curl (from inside container):
     - Port 8041 (Moodle 4.1)
     - Port 8043 (DH-Prod)
     - Port 8045 (Moodle 4.5)
     - Port 8051 (Moodle 5.1)
   - Expect HTTP 200 or 303 responses

6. **System Resources**
   - Disk usage: `df -h` (focus on /opt and /workspace)
   - Memory: `free -h`
   - Container resource usage: `docker stats --no-stream`

7. **Recent Errors**
   - Check last 10 lines of Nginx error logs for each instance
   - Check last 10 lines of PHP-FPM error logs
   - Highlight any critical errors

## Output Format

Present results in a clear table format:
```
SERVICE HEALTH CHECK
====================

Containers: ✓ 3/3 running
Services:   ✓ nginx, php8.1-fpm, php8.2-fpm, php8.3-fpm
Sockets:    ✓ 4/4 present
Database:   ✓ Connected, 4 databases
Web:        ✓ 4/4 instances responding

Disk:       45% used (/opt)
Memory:     12.3 GB / 16 GB used

Recent Errors: None
```

If any checks fail, provide specific details and suggested remediation steps.
