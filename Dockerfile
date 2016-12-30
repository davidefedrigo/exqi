FROM debian:stretch

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -qy apt-utils \
                      curl \
                      gnupg2 && \
  curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
  apt-get install -qy nodejs && \
  npm install -g yarn

RUN groupadd -g 1001 app && \
  useradd -g 1001 -u 1001 --system --create-home app

USER app

# CMD ["bash"]
ENTRYPOINT ["./entrypoint"]
