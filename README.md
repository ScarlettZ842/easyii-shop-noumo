## EasyiiCMS Shop

Control panel and tools based on php framework Yii2. Easy cms for easy websites with integrated shop functionality.

## Table of Contents

- [Requirements](#requirements)
- [Docker Installation](#docker-installation)
- [Quick Start](#quick-start)
- [Application URLs](#application-urls)
- [Database Information](#database-information)
- [Docker Commands](#docker-commands)
- [Features](#features)
- [Important Notes](#important-notes)
- [Directory Structure](#directory-structure)
- [Troubleshooting](#troubleshooting)
- [Resources](#resources)

## Requirements

### For Docker Setup (Recommended)

- Docker Desktop or Docker Engine
- Docker Compose v2.0+
- 4GB RAM minimum
- 10GB free disk space

### For Manual Setup

- PHP >= 8.0 (with extensions: GD, PDO, MySQLi, Zip)
- MySQL 8.0 or MariaDB 10.3+
- Apache/Nginx web server
- Composer

## Docker Installation

### Install Docker Desktop

**macOS:**

1. Download Docker Desktop from https://www.docker.com/products/docker-desktop
2. Install and start Docker Desktop
3. Verify installation: `docker --version`

**Windows:**

1. Download Docker Desktop from https://www.docker.com/products/docker-desktop
2. Install and start Docker Desktop
3. Enable WSL 2 if prompted
4. Verify installation: `docker --version`

**Linux:**

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install docker.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker

# Verify installation
docker --version
```

## Quick Start

1. **Clone or download this repository**

   ```bash
   cd /path/to/easyii-shop-noumo
   ```

2. **Start the application**

   ```bash
   docker compose up -d
   ```

   This command will:
   - Build the custom PHP-Apache image with all required extensions
   - Start MySQL 8.0 database
   - Start PHPMyAdmin
   - Install Composer dependencies automatically
   - Set up proper permissions
   - Start Apache web server

3. **Wait for initialization** (30-60 seconds on first run)
   The application will automatically install all PHP dependencies on first startup.

4. **Access the application**
   - Main Application: http://localhost:8080
   - Admin Panel: http://localhost:8080/admin
   - PHPMyAdmin: http://localhost:8081

## Application URLs

| Service             | URL                         | Credentials                                                              |
| ------------------- | --------------------------- | ------------------------------------------------------------------------ |
| **Web Application** | http://localhost:8080       | N/A                                                                      |
| **Admin Panel**     | http://localhost:8080/admin | Set during installation                                                  |
| **PHPMyAdmin**      | http://localhost:8081       | user: `easyii_user`<br>pass: `easyii_pass`<br>root pass: `root_password` |
| **MySQL Direct**    | localhost:3306              | Same as above                                                            |

## Database Information

### Connection Details

- **Host**: `mysql` (from containers) or `localhost` (from host machine)
- **Port**: `3306`
- **Database Name**: `easyii_shop`
- **Username**: `easyii_user`
- **Password**: `easyii_pass`
- **Root Password**: `root_password`

### Database Features

- MySQL 8.0 with persistent storage
- Automatic health checks
- Data persists in Docker volume `mysql_data`
- Character set: UTF-8

## Docker Commands

### Basic Operations

**Start the application**

```bash
docker compose up -d
```

**Stop the application**

```bash
docker compose down
```

**Restart services**

```bash
docker compose restart
```

**View logs**

```bash
# All services
docker compose logs

# Specific service
docker compose logs web
docker compose logs mysql

# Follow logs in real-time
docker compose logs -f web
```

**Check service status**

```bash
docker compose ps
```

### Advanced Operations

**Rebuild containers (after code changes)**

```bash
docker compose up -d --build
```

**Stop and remove all data (including database)**

```bash
docker compose down -v
```

**Access container shell**

```bash
# Web container
docker exec -it easyii-web bash

# MySQL container
docker exec -it easyii-mysql bash
```

**Run MySQL commands**

```bash
docker exec easyii-mysql mysql -u root -proot_password easyii_shop -e "SHOW TABLES;"
```

**View resource usage**

```bash
docker stats
```

## Features

### E-commerce Features

- ✅ Product catalog with categories
- ✅ Shopping cart functionality
- ✅ Order management system
- ✅ Customer order tracking
- ✅ Product search and filtering
- ✅ Product images and galleries
- ✅ Stock management

### CMS Features

- ✅ Article/Blog management
- ✅ News module
- ✅ FAQ module
- ✅ Gallery module
- ✅ Contact forms
- ✅ Guestbook
- ✅ File manager
- ✅ Admin panel with user management

### Technical Features

- ✅ PHP 8.0 compatible
- ✅ Yii2 framework
- ✅ Responsive admin interface
- ✅ RESTful API support
- ✅ Multi-language support
- ✅ SEO-friendly URLs
- ✅ Email notifications (file-based in development)
- ✅ Image optimization and thumbnails

## Important Notes

### PHP 8.0 Compatibility Fixes

This Docker setup includes several fixes for PHP 8.0 compatibility:

1. **Replaced deprecated `yii\base\Object`** with `yii\base\BaseObject`
2. **Fixed `count()` type errors** in Taggable behavior
3. **Fixed regex pattern errors** in phone validation
4. **Updated Fancybox asset paths** for newer version compatibility
5. **Fixed database schema** to allow nullable fields

### Development vs Production

**Current Setup (Development)**

- Debug mode enabled
- Email file transport (emails saved to `runtime/mail/`)
- Verbose error reporting
- Yii2 debug toolbar enabled

**For Production, change:**

```php
// In index.php
defined('YII_DEBUG') or define('YII_DEBUG', false);
defined('YII_ENV') or define('YII_ENV', 'prod');

// In app/config/web.php
'mailer' => [
    'class' => 'yii\swiftmailer\Mailer',
    'useFileTransport' => false,
    'transport' => [
        'class' => 'Swift_SmtpTransport',
        'host' => 'smtp.your-server.com',
        'username' => 'your-username',
        'password' => 'your-password',
        'port' => '587',
        'encryption' => 'tls',
    ],
],
```

### Email Configuration

Emails are currently saved as files in `runtime/mail/` directory instead of being sent via SMTP. This is perfect for development and testing. Check these files to see what emails would be sent.

To enable real email sending:

1. Update `app/config/web.php` mailer configuration
2. Set `useFileTransport` to `false`
3. Configure SMTP settings

## Directory Structure

```
easyii-shop-noumo/
├── app/                    # Main application
│   ├── assets/            # Asset bundles
│   ├── config/            # Configuration files
│   │   ├── db.php        # Database config
│   │   └── web.php       # Web application config
│   ├── controllers/       # Application controllers
│   ├── models/           # Application models
│   ├── views/            # Application views
│   └── web/              # Web root (public files)
├── assets/               # Published assets
├── runtime/              # Runtime files
│   ├── cache/           # Cache files
│   ├── logs/            # Application logs
│   └── mail/            # Email files (development)
├── uploads/              # User uploaded files
├── vendor/               # Composer dependencies
├── docker/               # Docker configuration
│   ├── apache/          # Apache configs
│   │   ├── 000-default.conf
│   │   └── php.ini
│   ├── mysql-init/      # MySQL initialization scripts
│   └── start.sh         # Container startup script
├── docker-compose.yml    # Docker Compose configuration
├── Dockerfile           # Docker image definition
└── composer.json        # PHP dependencies

```

## Troubleshooting

### Port Already in Use

If ports 8080, 8081, or 3306 are already in use:

**Option 1: Change ports in docker-compose.yml**

```yaml
services:
  web:
    ports:
      - "8888:80" # Change 8080 to 8888
```

**Option 2: Stop conflicting services**

```bash
# Find process using port
lsof -i :8080

# Kill process
kill -9 <PID>
```

### Container Won't Start

```bash
# Check logs
docker compose logs web

# Rebuild from scratch
docker compose down -v
docker compose up -d --build
```

### Database Connection Error

```bash
# Wait for MySQL to be ready
docker compose logs mysql | grep "ready for connections"

# Restart containers
docker compose restart
```

### Permission Errors

```bash
# Fix permissions
docker exec easyii-web chmod -R 777 /var/www/html/runtime /var/www/html/uploads /var/www/html/assets
```

### Composer Dependencies Missing

```bash
# Reinstall dependencies
docker exec easyii-web composer install
```

### Clear Cache

```bash
# Remove cache files
docker exec easyii-web rm -rf /var/www/html/runtime/cache/*

# Or from host
rm -rf runtime/cache/*
```

## Resources

- [EasyiiCMS Homepage](http://easyiicms.com)
- [Installation Guide](http://easyiicms.com/docs/install)
- [Live Demo](http://demo.easyiicms.com/)
- [Yii2 Framework Documentation](https://www.yiiframework.com/doc/guide/2.0/en)
- [Docker Documentation](https://docs.docker.com/)

## Support

For issues and questions:

- GitHub Issues: Create an issue in this repository
- Email: noumohope@gmail.com

## Screenshots
<img width="1004" height="708" alt="Screenshot 2026-01-27 at 19 06 03" src="https://github.com/user-attachments/assets/73fa2b30-454a-46ee-a257-2d88fc4ac953" />
<img width="1007" height="745" alt="Screenshot 2026-01-27 at 19 06 20" src="https://github.com/user-attachments/assets/10fca18b-fe4d-419a-a1a6-329390cc1ecc" />
<img width="992" height="728" alt="Screenshot 2026-01-27 at 19 06 57" src="https://github.com/user-attachments/assets/027fdfe7-6602-4ab6-812f-6224c5641a6b" />
<img width="1265" height="566" alt="Screenshot 2026-01-29 at 17 21 13" src="https://github.com/user-attachments/assets/6b0a2933-bdbd-4d9a-af18-b5b747b99aee" />
<img width="1114" height="453" alt="Screenshot 2026-01-29 at 17 22 33" src="https://github.com/user-attachments/assets/64358515-63dc-489b-bfec-8f5c65b965b8" />






GNU GPL V3

---

**Note**: This is a development setup with Docker. For production deployment, additional security hardening and configuration changes are required.
