README.md
=================

Authoring SCORM-compatible training using the [Adapt Authoring](https://github.com/adaptlearning/adapt_authoring) tool at http://localhost:5000.

Login credentials are set from a .env file (See _Config_ section).

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

Create local archives of both the adapt_authoring folder and database:

```
docker run -it -w /backup -v dockeradaptauthoring_adaptdb:/adaptdb -v $(pwd)/backup:/backup dockeradaptauthoring_authoring bash -c "tar -czvf adaptdata_`date +"%Y-%m-%d_%H-%M-%S"`.tar.gz /adapt_authoring && tar -czvf adaptdb_`date +"%Y-%m-%d_%H-%M-%S"`.tar.gz /adaptdb"
```

Getting Started - Using `docker run ...`
--------------------------------------------

### Setup

`docker run -d --name adaptdb -v adaptdb:/data/db mongo`

Adjust values such as `--email` and `--password` as desired:

```bash
docker run -it -p 5000:5000 --link adaptdb --name adaptauthoring -v adaptdata:/adapt_authoring garyritchie/docker-adaptauthoring bash -c 'node install --install Y --serverPort 5000 --serverName localhost --dbHost adaptdb --dbName adapt-tenant-master --dbPort 27017 --dataRoot data --sessionSecret your-session-secret --useffmpeg Y --smtpService dummy --smtpUsername smtpUser --smtpPassword smtpPass --fromAddress you@example.com --name master --displayName Master --email admin --password password'
```

After a while the container should quit and you should see the following message"

```bash
Done, without errors.

The app.productname web application was compiled and is now ready to use.
Installation complete.
To restart your instance run the command 'pm2 restart all'
Bye!
```


### Run

Once the "Setup" steps are complete, do:

`docker restart adaptauthoring`

Adapt authoring tool should now be available at http://localhost:5000/


### Upgrade

*Please Note:* Upgrading has had mixed results in recent tests.

Upgrade the AuthoringTool and or Framework (run in a shell):

```bash
docker exec -it adaptauthoring bash -c 'node upgrade --Y/n Y'
```

`node upgrade` has been stalling... `docker run -it -p 5000:5000 --link adaptdb --name adaptauthoring -v adaptdata:/adapt_authoring garyritchie/docker-adaptauthoring bash -c 'node upgrade --Y/n Y'`

After a bit you should see:

`Great work! Your Adapt authoring tool is now updated.`
