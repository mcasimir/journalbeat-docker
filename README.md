# Journalbeat docker image

```
docker run \
    -d \
    --restart always \
    -v /var/tmp/journalbeat:/data \
    -v /var/log/journal:/var/log/journal \
    -e ELASTICSEARCH_HOST=elasticsearch:9200 \
    mcasimir/journalbeat
```
