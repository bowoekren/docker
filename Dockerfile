FROM ruby:2.5.0-alpine as base
RUN apk add --no-cache \
    build-base \
    libxml2-dev \
    libxslt-dev \
    postgresql-dev \
    nodejs \
    sqlite-dev \
    && apk add --update less \
    && gem install nokogiri \
    && gem update --system \
    && gem install bundler

FROM base
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle
RUN npm install -g yarn
COPY . /myapp
RUN yarn install
# # Note this is for development only, Running in production might be different run.sh
# COPY docker-entrypoint.sh /usr/local/bin/
# RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
# ENTRYPOINT ["docker-entrypoint.sh"]