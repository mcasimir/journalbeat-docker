FROM debian:jessie-slim
COPY bin /bin
COPY conf /conf

RUN chmod +x /bin/journalbeat-debian
CMD ["/bin/journalbeat-debian", "-e", "-c", "/conf/journalbeat.yml", "-path.config", "/conf", "-path.data", "/data"]
