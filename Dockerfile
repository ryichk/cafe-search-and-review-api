FROM ruby:2.6.0

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
RUN apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev imagemagick

WORKDIR /cafe-shares

COPY Gemfile /cafe-shares/Gemfile
# COPY Gemfile.lock /cafe-shares/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /cafe-shares