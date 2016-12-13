FROM node:4-wheezy

MAINTAINER Gary Ritchie <gary@garyritchie.com>

## Adapt Authoring release
ENV AAT_VER=v0.2.2

RUN export DEBIAN_FRONTEND='noninteractive' && \
  apt-get update -qq && apt-get install -qqy \
  build-essential \
  ffmpeg \
  git \
  libssl-dev \
  && rm -rf /var/lib/apt/lists/*

# global npm dependencies
RUN npm install -g pm2 \
  && npm install -g grunt-cli \
  && npm install -g adapt-cli

RUN cd / \
  && git clone --branch ${AAT_VER} https://github.com/adaptlearning/adapt_authoring.git

WORKDIR /adapt_authoring

RUN npm install --production

## Currently have to run this within container so we can link to running mongodb container...
COPY install.sh install.sh
RUN chmod u+x install.sh

# upgrade the AuthoringTool and or Framework
# RUN node upgrade --Y/n Y

# guest: 5000, host: 5000
# guest: 5858, host: 5858
# guest: 27017, host: 27027

EXPOSE 5000

CMD pm2 start --no-daemon processes.json
