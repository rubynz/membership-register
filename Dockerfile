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

ENV RAILS_ENV production
ENV RACK_ENV production

COPY . $APP_HOME
WORKDIR $APP_HOME

RUN bundle config set --local without 'development test'
RUN bundle install
RUN yarn install
RUN bundle exec rake assets:precompile

RUN rm Dockerfile

RUN rm -f /swapfile \
    && dd if=/dev/zero of=/swapfile bs=1024 count=1048576 \
    && mkswap /swapfile \
    && chmod 600 /swapfile

EXPOSE ${PORT:-3000}
CMD swapon /swapfile; bundle exec falcon serve -n "${FALCON_INSTANCES:-1}" -b "tcp://0.0.0.0:${PORT:-3000}"
