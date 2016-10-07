README.md
=================

Authoring SCORM-compatible training using the [Adapt Authoring](https://github.com/adaptlearning/adapt_authoring) tool.

Getting Started - docker-compose
---------------------------------

### Config

Add an `.env` file with the following:

```
ADMIN_EMAIL=admin
ADMIN_PASSWORD=password
```

This is read during "setup."

### Setup

Do this once:

```
docker-compose up -d
```

wait for a moment, then

```
docker-compose -f docker-compose.setup.yml run --rm setup

```

Subsequent runnings: `docker-compose up -d`.


### Clean Up

#### To remove containers

```
docker-compose down
```

#### To remove data (courses)

This will delete your hard work.

```
docker volume rm dockeradaptauthoring_adaptdb
docker volume rm dockeradaptauthoring_adaptdata
```

### Backup

[database and course content]

Getting Started - docker run
---------------------------------

Setup
-----------

### Volumes

`docker volume create --name adaptdata`

### Services

`docker run -d --name adaptdb -v adaptdb:/data/db mongo`

Adjust values such as `--email` and `--password` as desired:

```bash
docker run -it --rm -P --link adaptdb --name adaptauthoring -v adaptdata:/adapt_authoring garyritchie/docker-adaptauthoring bash -c 'node install --install Y --serverPort 5000 --serverName localhost --dbHost adaptdb --dbName adapt-tenant-master --dbPort 27017 --dataRoot data --sessionSecret your-session-secret --useffmpeg Y --smtpService dummy --smtpUsername smtpUser --smtpPassword smtpPass --fromAddress you@example.com --name master --displayName Master --email admin --password password'
```

After a while the container should quit and you should see the following message"

```bash
Done, without errors.

The app.productname web application was compiled and is now ready to use.
Installation complete.
To restart your instance run the command 'pm2 restart all'
Bye!
```

Upgrade the AuthoringTool and or Framework:

```bash
docker run -it --rm -P --link adaptdb --name adaptauthoring -v adaptdata:/adapt_authoring garyritchie/docker-adaptauthoring bash -c 'node upgrade --Y/n Y'
```

Run
-------

```bash
docker run -d  -p 5000:5000 --link adaptdb --name adaptauthoring garyritchie/docker-adaptauthoring bash -c 'pm2 start --no-daemon processes.json'
```