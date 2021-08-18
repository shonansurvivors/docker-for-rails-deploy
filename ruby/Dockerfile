FROM node:12 as node
FROM ruby:2.6.8

COPY --from=node /usr/local/bin /usr/local/bin
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /opt /opt

ENV APP_ROOT /var/www
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

ENV BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    BUNDLE_PATH=vendor/bundle \
    BUNDLE_APP_CONFIG=$APP_ROOT/.bundle

RUN gem update --system && \
    gem install --no-document bundler:2.1.4
