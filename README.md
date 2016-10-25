README.md
=================

Authoring SCORM-compatible training using the [Adapt Authoring](https://github.com/adaptlearning/adapt_authoring) tool at http://localhost:5000.

Login credentials are set from a .env file (See _Config_ section).

Getting Started
---------------------

Do this once:

```
docker-compose up -d
```

If you're using Windows skip to _Windows Setup_, otherwise wait for a moment, then

```
docker-compose -f docker-compose.setup.yml run --rm setup

```

Subsequent runnings: `docker-compose up -d`.

### Windows Setup

Docker's `docker-compose` command on Windows isn't fully supported. Here's an alternate method for updating the _adaptauthoring_ container:

`docker exec -it` into the running _adaptauthoring_ container, then

```bash
export ADMIN_EMAIL=admin

export ADMIN_PASSWORD=password

node install --install Y --serverPort 5000 --serverName localhost --dbHost adaptdb --dbName adapt-tenant-master --dbPort 27017 --dataRoot data --sessionSecret your-session-secret --useffmpeg Y --smtpService dummy --smtpUsername smtpUser --smtpPassword smtpPass --fromAddress you@example.com --name master --displayName Master --email ${ADMIN_EMAIL} --password ${ADMIN_PASSWORD}
```

Exit and then restart the container.

Config
----------

Add an `.env` file with the following:

```
ADMIN_EMAIL=admin
ADMIN_PASSWORD=password
```

This is read during "setup."

Clean Up
-----------

### To remove containers

```
docker-compose down
```

### To remove data (courses)

This will delete your hard work. Are you sure?

```
docker volume rm dockeradaptauthoring_adaptdb
docker volume rm dockeradaptauthoring_adaptdata
```

Backup
------------

[database and course content]