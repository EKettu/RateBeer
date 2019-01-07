FROM ruby:2.5.1

WORKDIR /app

COPY . .

RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs
RUN bin/rails db:migrate RAILS_ENV=development

EXPOSE 3000

CMD ["rails", "server"]
