FROM ruby:2.5.1
RUN mkdir /rn_test
WORKDIR /rn_test
COPY Gemfile /rn_test/Gemfile
COPY Gemfile.lock /rn_test/Gemfile.lock
RUN bundle install
COPY . /rn_test

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]