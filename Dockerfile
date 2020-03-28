#same as minddocdev/flutter
FROM mindrunner/docker-android-sdk:latest

ARG VERSION=v1.9.1+hotfix.2

ENV FLUTTER_PATH=/flutter/bin

WORKDIR /

RUN apt-get update &&\
 apt-get install -y lcov git-core curl unzip libglu1 lib32stdc++6 &&\
 git clone --branch ${VERSION} --depth=1 https://github.com/flutter/flutter.git &&\
 ${FLUTTER_PATH}/flutter doctor &&\
 apt autoremove -y &&\
 rm -rf /var/lib/apt/lists/*
 
ENV PATH $PATH:${FLUTTER_PATH}/cache/dart-sdk/bin:${FLUTTER_PATH}

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
