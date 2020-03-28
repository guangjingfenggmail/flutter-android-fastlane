#same as minddocdev/flutter
FROM ubuntu:18.04

ARG VERSION=v1.9.1+hotfix.2

ENV FLUTTER_PATH=/flutter/bin

WORKDIR /

RUN apt-get update &&\
 apt-get install -y lcov git-core curl unzip libglu1 lib32stdc++6 &&\
 git clone --branch ${VERSION} --depth=1 https://github.com/flutter/flutter.git &&\
 ${FLUTTER_PATH}/flutter doctor
 
 ENV PATH $PATH:${FLUTTER_PATH}/cache/dart-sdk/bin:${FLUTTER_PATH}

 RUN dpkg --add-architecture i386 &&  apt-get install -y \
  curl \
  expect \
  git \
  make \
  libc6:i386 \
  libgcc1:i386 \
  libncurses5:i386 \
  libstdc++6:i386 \
  zlib1g:i386 \
  openjdk-8-jdk \
  wget \
  unzip \
  vim \
  openssh-client \
  locales \
  nodejs \
  npm \
  && apt-get clean


RUN  rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.UTF-8

## same as trevorwang/android-sdk-fastlane
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8

RUN apt-get install -y build-essential ruby-full
RUN gem install bundler

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get install yarn
