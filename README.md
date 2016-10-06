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

`docker volume create --name dockeradaptauthoring_adaptdata`

### Services