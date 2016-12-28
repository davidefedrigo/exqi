FROM ubuntu:14.04

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y nodejs nodejs-legacy npm build-essential

RUN npm install -g elm
RUN npm install -g elm-test

CMD ["bash"]
