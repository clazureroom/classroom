FROM node

RUN node -v
RUN npm -v
RUN yarn --version

RUN mkdir /classroom
WORKDIR /classroom

COPY package.json /classroom/package.json
COPY yarn.lock /classroom/yarn.lock

RUN yarn install

########
FROM ruby:2.6.4

RUN apt-get update
RUN apt-get install -y nodejs

RUN gem install bundler -v 2.0.2

WORKDIR /classroom

COPY package.json /classroom/package.json
COPY yarn.lock /classroom/yarn.lock

#RUN npm install -g yarn

RUN which env
RUN ruby -v
RUN bundle -v
RUN node -v
#RUN yarn --version

COPY Gemfile /classroom/Gemfile
COPY Gemfile.lock /classroom/Gemfile.lock
COPY .ruby-version /classroom/.ruby-version

COPY . /classroom

#https://classic.yarnpkg.com/en/docs/install#debian-stable
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get install -y yarn

RUN bundle install --without assets
RUN bundle exec rake assets:precompile

RUN apt-get update -qq
RUN apt-get install dos2unix
RUN find ./ -type f -exec dos2unix -q {} \;

CMD ["bin/puma", "-C", "config/puma.rb"]
