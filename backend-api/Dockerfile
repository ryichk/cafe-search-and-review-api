FROM ruby:2.6.0

WORKDIR /cafe-shares-api
COPY . /cafe-shares-api

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs \
    && apt-get update && apt-get install -y mysql-client --no-install-recommends && rm -rf /var/lib/apt/lists/* \
    && apt-get update -qq && apt-get install -y build-essential libpq-dev imagemagick \
    && gem install bundler:2.2.15 && bundle install

CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]