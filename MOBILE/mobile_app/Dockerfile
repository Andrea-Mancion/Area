FROM ubuntu:latest

RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

WORKDIR /home/dev

RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/dev/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/dev/Android/sdk/platform-tools"

RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/dev/flutter/bin"

RUN apt-get install -y openjdk-11-jdk

RUN flutter doctor

WORKDIR /app
COPY . .
RUN flutter build apk
