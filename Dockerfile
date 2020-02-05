FROM node

RUN node -v
RUN npm -v

RUN mkdir /classroom
WORKDIR /classroom

COPY package.json /classroom/package.json
COPY yarn.lock /classroom/yarn.lock

#COPY package-lock.json /classroom/pacakge-lock.json

RUN npm install
RUN yarn install

FROM ruby:2.6.4

RUN gem install bundler -v 2.0.2

RUN which env
RUN which ruby
RUN ruby -v
RUN bundle -v

WORKDIR /classroom
COPY Gemfile /classroom/Gemfile
COPY Gemfile.lock /classroom/Gemfile.lock
COPY .ruby-version /classroom/.ruby-version

RUN bundle update
RUN bundle install
COPY . /classroom

RUN ls
RUN pwd

RUN apt-get update -qq
RUN apt-get install dos2unix
RUN find ./ -type f -exec dos2unix {} \;

CMD ["bin/puma", "-C", "config/puma.rb"]