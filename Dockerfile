FROM ruby:3.2.2 AS builder

WORKDIR /opt/app
RUN gem install bundle

#######################################

FROM builder AS dev

COPY bashrc /root/.bashrc

ENV APP_ENV development
ENV RUBYOPT "-W:no-deprecated"

RUN bundle config set with 'development'
RUN gem install bundle

ENV PORT 8080
EXPOSE 8080

#######################################

FROM ruby:3.2.2 AS production

WORKDIR /opt/app
COPY --from=builder /usr/local/ /usr/local/
COPY --from=builder /opt/app/ /opt/app
COPY . /opt/app/

ENV PORT 8080
EXPOSE 8080

ENV APP_ENV production
ENV RUBYOPT "-W:no-deprecated"

CMD ["ruby", "./app.rb"]
