# usage:
#   docker build -t firebase -f Dockerfile.firebase .
#   docker run -it -v $HOME:/root -it firebase init --no-localhost
#
#   docker run -v $HOME/.config/configstore:/root/.config/configstore firebase version

# ref:
#   install: https://firebase.google.com/docs/cli#install-cli-mac-linux
#   config :https://firebase.google.com/docs/emulator-suite/install_and_configure

FROM openjdk:slim

RUN set -ex \
  && apt-get update \
  && apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash \
  && apt-get install -y nodejs \
  && npm install -g firebase-tools

# https://firebase.google.com/docs/emulator-suite/install_and_configure#port_configuration
# Emulator Suite UI
EXPOSE 4000
# Authentication
EXPOSE 8080
# Firestore
EXPOSE 9099

ENTRYPOINT ["firebase"]
