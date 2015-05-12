#!/usr/bin/env bash


cp config/database.sample.yml config/database.yml;
cp config/secrets.sample.yml config/secrets.yml;



bundle install;

sed -i "s/secret_key_base: \w\+/secret_key_base: `bundle exec rake secret`/g" config/secrets.yml;
sed -i "s/  # config.secret_key = '.*'/  config.secret_key = '`bundle exec rake secret`'/g" config/initializers/devise.rb;

RAILS_ENV=production rake db:create db:migrate;
RAILS_ENV=production rake assets:precompile;


sudo service nginx restart;
