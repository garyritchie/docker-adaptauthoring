# Exposes port 27017 on linked "db" container, to be accessible at host:[some-port]
FROM mongo

RUN export DEBIAN_FRONTEND='noninteractive' && \
    apt-get update && \
    apt-get -y install socat && \
    apt-get clean

USER nobody
# EXPOSE 27000

CMD socat -dddd TCP-LISTEN:27017,reuseaddr,fork TCP:db:27017