FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /miaoapp
WORKDIR /miaoapp
ADD . /miaoapp
RUN bundle install
RUN bundle exec rails db:drop
RUN bundle exec rails db:create
RUN bundle exec rails db:migrate
RUN bundle exec rails db:seed