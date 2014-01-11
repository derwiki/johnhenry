#!/bin/bash
set -e

if [ -z "$projectname" ]; then
  echo "  Err: please run 'export projectname=\"MyWebSiteName\"' and try again."
  exit -1
fi

#TODO: quit if no: rails, git, bundle, heroku

lowercaseprojectname=`echo $projectname | awk '{print tolower($0)}'`
rails new $projectname
cd $projectname
git init
heroku create $lowercaseprojectname
git add .
git commit -m "rails new $projectname"
echo "gem 'johnhenry'" >> Gemfile
bundle
bundle exec rake john_henry:install
bundle
git add app config Gemfile*
git rm app/views/layouts/application.html.erb
git commit -m 'Install JohnHenryRails'
bundle exec rake john_henry:install:migrations
bundle exec rake db:migrate
git add db
git commit -m 'Add initial migrations and schema.rb'
git push heroku master
heroku run rake db:migrate
heroku restart
echo Success! Point your browser to: http://$lowercaseprojectname.herokuapp.com
