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

wait for a moment, then

```
docker-compose -f docker-compose.setup.yml run --rm setup

```

Subsequent runnings: `docker-compose up -d`.

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

Create local archives of both the adapt_authoring folder and database:

```
docker run -it -w /backup -v dockeradaptauthoring_adaptdb:/adaptdb -v $(pwd)/backup:/backup dockeradaptauthoring_authoring bash -c "tar -czvf adaptdata_`date +"%Y-%m-%d_%H-%M-%S"`.tar.gz /adapt_authoring && tar -czvf adaptdb_`date +"%Y-%m-%d_%H-%M-%S"`.tar.gz /adaptdb"
```
