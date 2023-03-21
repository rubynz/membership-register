from ruby:3.2.1-alpine

RUN apk add postgresql-dev postgresql-client
RUN apk add nodejs npm
RUN apk add tzdata

# for nokogiri
RUN apk add --virtual .ruby-gemdeps libc-dev gcc libxml2-dev libxslt-dev make libffi-dev
# for sassc
RUN apk add g++

RUN npm install -g yarn

ENV TZ Pacific/Auckland
ENV BUNDLE_JOBS 8

ENV APP_HOME /myapp

ARG RAILS_ENV=production
ENV RAILS_ENV=$RAILS_ENV
ENV RACK_ENV=$RAILS_ENV

COPY . $APP_HOME
WORKDIR $APP_HOME

RUN if [ "$RAILS_ENV" = "production" ]; then \
    bundle config set --local without 'development test' \
    && bundle install \
    && yarn install \
    && bundle exec rake assets:precompile \
    && rm -f /swapfile \
    && dd if=/dev/zero of=/swapfile bs=1024 count=1048576 \
    && mkswap /swapfile \
    && chmod 600 /swapfile; \
    fi

RUN rm Dockerfile

EXPOSE ${PORT:-3000}
CMD if [ -f /swapfile ]; then swapon /swapfile; fi; \
    bundle exec falcon serve -n "${FALCON_INSTANCES:-1}" -b "tcp://0.0.0.0:${PORT:-3000}"
