FROM debian:12 AS builder

RUN apt-get update; \
  apt-get install \
  --no-install-recommends  \
  -y \
  curl git unzip apt-transport-https ca-certificates \
  wget libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3; \
  update-ca-certificates

ARG FLUTTER_SDK=/tmp/flutter
ARG FLUTTER_VERSION=3.22.0
ARG APP=/app/

ENV PATH="$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin:${PATH}"

RUN adduser builder && adduser builder builder
USER builder

RUN git clone --depth 1 --branch $FLUTTER_VERSION https://github.com/flutter/flutter.git $FLUTTER_SDK
WORKDIR $FLUTTER_SDK
RUN flutter doctor -v
RUN flutter channel stable; \
  flutter config --enable-web

WORKDIR $APP
COPY --chown=builder:builder ./pubspec.yaml ./pubspec.lock ./
RUN flutter clean; \
  flutter pub get;
COPY --chown=builder:builder . $APP
RUN flutter build web --release

FROM nginx:1.25.2-alpine

RUN rm -rf /usr/share/nginx/html
COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
