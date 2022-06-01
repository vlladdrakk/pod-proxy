FROM ruby:3.0.3

WORKDIR /app/src

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .

ENV PORT=9292
ENV DOMAIN="localhost"
ENV USE_PORT="false"

CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]