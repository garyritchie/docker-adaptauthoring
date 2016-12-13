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

```bash
docker-compose up -d
```

If you're using Windows skip to _Windows Setup_, otherwise wait for a moment, then

```bash
docker-compose -f docker-compose.setup.yml run --rm setup

```

Subsequent runnings: `docker-compose up -d`.

### Windows Setup

Docker's `docker-compose` command on Windows isn't fully supported. Here's an alternate method for updating the _adaptauthoring_ container:

```bash
docker run --name adapt-setup --rm --env-file .env -v dockeradaptauthoring_adaptdata:/adapt_authoring --link adaptdb --net dockeradaptauthoring_default garyritchie/docker-adaptauthoring:0.2.2 bash -c "./install.sh"
```

or

`docker exec -it` into the running _adaptauthoring_ container, then

```bash
export ADMIN_EMAIL=admin

export ADMIN_PASSWORD=password

node install --install Y --serverPort 5000 --serverName localhost --dbHost adaptdb --dbName adapt-tenant-master --dbPort 27017 --dataRoot data --sessionSecret your-session-secret --useffmpeg Y --smtpService dummy --smtpUsername smtpUser --smtpPassword smtpPass --fromAddress you@example.com --name master --displayName Master --email ${ADMIN_EMAIL} --password ${ADMIN_PASSWORD}
```

Exit and then restart the container.

### Clean Up

#### To Remove Containers

```bash
docker-compose down
```

#### To Remove Data

This will delete the Docker volumes that contain files and the database for the courses as well as the Docker image for Adapt Authoring.

```bash
docker-compose down -v --rmi local
```

Changing `--rmi local` to `--rmi all` will also remove the mongo Docker image.

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
