from ruby:2.7.4

env \
  DEBIAN_FRONTEND=noninteractive \
  NODE_VERSION=14.17.2

run \
  sed -i "/deb-src/d" /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y build-essential libpq-dev postgresql-client unzip cmake && \
  curl -sSL "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" | tar xfJ - -C /usr/local --strip-components=1
