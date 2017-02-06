# Journalbeat docker image

## Run on a single host

```
docker run \
    -d \
    --restart always \
    -v /var/tmp/journalbeat:/data \
    -v /var/log/journal:/var/log/journal \
    -e ELASTICSEARCH_HOST=elasticsearch:9200 \
    -e LOG_LEVEL=warning \
    mcasimir/journalbeat
```

## Run on a single hos+t as `docker-compose v2` service

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
      - "/var/log/journal:/var/log/journal"
```

## Deploy in `global` mode on swarm with `docker service create`

```
docker service create \
  --name journalbeat \
  --mode global
  --mount type=bind,source=/var/tmp/journalbeat,destination=/data \
  --mount type=bind,source=/var/log/journal,destination=/var/log/journal \
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
      - "/var/log/journal:/var/log/journal"

    deploy:
      mode: "global"
```

```
docker stack deploy -c docker-compose.yml journalbeat
```
