FROM ruby:2.6.5
ENV RAILS_ENV production
ENV RAILS_LOG_TO_STDOUT true

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn dos2unix

# Copy Gemfile so we can cache gems
COPY Gemfile Gemfile.lock ./

# Install Ruby gems
RUN gem install bundler:2.2.17
RUN bundle install --without development test

# Copy all application files
COPY . .

RUN chmod +x entrypoint.sh

RUN dos2unix /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]