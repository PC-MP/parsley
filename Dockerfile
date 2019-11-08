FROM ruby:2.6.5-buster

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}

ENV APP_ROOT /var/rails
ENV TZ JST-9
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS yes
ENV RAILS_LOG_TO_STDOUT true
ENV PORT 3000
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV DATABASE_URL mysql2://root:mysql123@db/rails_app?reconnect=true&prepared_statements=true&encoding=utf8mb4

RUN apt-get update -qq && \
    apt-get install -y apt-transport-https apt-utils && \
    apt-get dist-upgrade -qq

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get install -qq -y yarn nodejs

RUN apt-get clean -qq && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN gem install bundler --no-document

WORKDIR $APP_ROOT
COPY Gemfile Gemfile.lock package.json yarn.lock $APP_ROOT/

RUN bundle install --deployment --without development test

RUN yarn install

ADD . $APP_ROOT

RUN bundle exec rake assets:precompile

EXPOSE $PORT

CMD bundle exec rails s -p $PORT -b 0.0.0.0 -e $RAILS_ENV

# HEALTHCHECK CMD curl -s -S http://${HOSTNAME}:3000/healthz
