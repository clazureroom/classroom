FROM ruby:2.6.4

RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y yarn

RUN gem install bundler -v 2.0.2

RUN mkdir /classroom
WORKDIR /classroom

COPY package.json /classroom/package.json
COPY yarn.lock /classroom/yarn.lock

RUN which env
RUN ruby -v
RUN bundle -v
RUN node -v
RUN yarn --version

COPY Gemfile /classroom/Gemfile
COPY Gemfile.lock /classroom/Gemfile.lock
COPY .ruby-version /classroom/.ruby-version

COPY . /classroom

RUN bundle install --without assets
RUN bundle exec rake assets:precompile

RUN apt-get update -qq
RUN apt-get install dos2unix
RUN find ./ -type f -exec dos2unix {} \;

CMD ["bin/puma", "-C", "config/puma.rb"]
