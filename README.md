rails new SampleProject
cd SampleProject
# add gem 'rails4payment' to Gemfile
bundle
bundle exec rails4payment:install:migrations
bundle exec db:migrate
# edit config/routes
