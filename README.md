# Journalbeat docker image

## Run on a single host

```
docker run \
    -d \
    --restart always \
    -v /var/tmp/journalbeat:/data \
    -v /run/log/journal:/var/log/journal \
    -v /etc/machine-id:/etc/machine-id \
    -e ELASTICSEARCH_HOST=elasticsearch:9200 \
    -e LOG_LEVEL=warning \
    mcasimir/journalbeat
```

Check that an index has been created with:

```
curl -XGET 'elasticsearch:9200/_cat/indices?v&pretty'
```

**NOTE:** The host path for the mount `/run/log/journal:/var/log/journal` is different from an os to another.

## Run on a single host as `docker-compose v2` service

``` yaml
version: '2'

services:
  beat:
    restart: always
    image: mcasimir/journalbeat

    environment:
      ELASTICSEARCH_HOST: elasticsearch.example.com:9200
      LOG_LEVEL: warning

    volumes:
      - "/var/tmp/journalbeat:/data"
      - "/run/log/journal:/var/log/journal"
      - "/etc/machine-id:/etc/machine-id"
```

## Deploy in `global` mode on swarm with `docker service create`

```sh
docker service create \
  --name journalbeat \
  --mode global \
  -v "/var/tmp/journalbeat:/data" \
  -v "/run/log/journal:/var/log/journal" \
  -v "/etc/machine-id:/etc/machine-id" \
  -e ELASTICSEARCH_HOST=elasticsearch:9200 \
  -e LOG_LEVEL: warning \
  mcasimir/journalbeat
```

## Deploy in `global` mode on swarm with `docker stack deploy` and `docker-compose v3` (docker 1.13+)

``` yaml
version: '3'

services:
  beat:
    image: mcasimir/journalbeat

    environment:
      ELASTICSEARCH_HOST: elasticsearch.example.com:9200
      LOG_LEVEL: warning

    volumes:
      - "/var/tmp/journalbeat:/data"
      - "/run/log/journal:/var/log/journal"
      - "/etc/machine-id:/etc/machine-id"

    deploy:
      mode: "global"
```

```sh
docker stack deploy -c docker-compose.yml journalbeat
```
