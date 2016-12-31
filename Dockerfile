FROM debian:stretch

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -qqy apt-utils \
                      curl \
                      wget \
                      vim \
                      build-essential \
                      lsb-release \
                      openssl \
                      locales \
                      apt-utils \
                      libssl-dev \
                      gnupg2 && \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb && \
  echo "deb http://binaries.erlang-solutions.com/debian stretch contrib" > /etc/apt/sources.list.d/erlang-solutions.list && \
  DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get install -qqy nodejs \
                      esl-erlang \
                      elixir && \
  mix local.hex --force && \
  mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez && \
  npm install -g yarn

RUN groupadd -g 1001 app && \
  useradd -g 1001 -u 1001 --system --create-home app

USER app

# CMD ["bash"]
ENTRYPOINT ["./entrypoint"]
