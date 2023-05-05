FROM node:10-stretch

ENV AAT_VER=0.2.2

MAINTAINER Vadim Prishlyak

RUN apt-get update && apt-get install -y \
    build-essential \
    ffmpeg libavcodec-dev libavdevice-dev\
    git nfs-common\
    libssl-dev \
  && rm -rf /var/lib/apt/lists/*

# global npm dependencies
RUN npm install -g pm2 \
  && npm install -g grunt-cli \
  && npm install -g adapt-cli

RUN cd / \
  && git clone https://github.com/adaptlearning/adapt_authoring.git

WORKDIR /adapt_authoring

RUN npm install --production

## Currently have to run this within container so we can link to running mongodb container...
## docker run -it -P --link adaptdb --name adapt adaptframework bash
#RUN node install --install Y --serverPort 5000 --serverName localhost --dbHost 127.0.0.1 \
  # --dbName adapt-tenant-master --dbPort 27017 \
  # --dataRoot data --sessionSecret your-session-secret --useffmpeg Y \
  # --smtpService dummy --smtpUsername smtpUser --smtpPassword smtpPass --fromAddress you@example.com \
  # --name master --displayName Master --email admin --password password

# upgrade the AuthoringTool and or Framework
RUN node upgrade --Y/n Y

# guest: 5000, host: 5000
# guest: 5858, host: 5858
# guest: 27017, host: 27027

EXPOSE 5000

CMD pm2 start --no-daemon processes.json
