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