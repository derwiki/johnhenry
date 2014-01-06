# Introduction
Thanks for downloading JohnHenry, the fastest way to launch a new Ruby on
Rails web application on Heroku with Bootstrap.

# Installation on Mac OS X (and probably Linux)
All commands are run via Terminal, which you can find in your
Applications folder. If you're already using Terminal, try switching to iTerm
and see if you like it any better.

Note: this assumes that you've already got Ruby 2.0 and a Rails 4.0+ gem
installed. If you haven't, head over to http://rvm.io and then come back. You
can verify both with:

```bash
$ ruby -v
ruby 2.0.0p247 (2013-06-27 revision 41674) [x86_64-darwin12.3.0]
Adams-MacBook-Pro:~/src/johnhenry[master *+%]
$ rails -v
Rails 4.0.2
```

1. Create a new Rails project:
   `rails new SampleProject && cd SampleProject`

1. Download and apply installation patch:
```bash
curl https://gist.github.com/derwiki/85e4f831cb893d7e06f1/raw/dbf5b1adbe8b88d6ecff2c028c13bdb035ef3095/install-johnhenry.patch > install-johnhenry.patch
# view stats of the patch about to be applied
git apply --stat install-johnhenry.patch
# git 'apply mailbox' downloaded patch into local commit
git am install-johnhenry.patch
```
1. Run bundle to update Gemfile.lock and then create database:
```bash
bundle
git commit Gemfile.lock -m "Generated Gemfile.lock from bundle install"
```

1. Install database migrations and run them
```bash
bundle exec rake johnhenry:install:migrations
bundle exec rake db:migrate
git add db && git commit -m "Add initial migrations and schema.rb"
```

1. Try the server locally:
```bash
bundle exec rails server
```
and load `http://localhost:3000/` in your web browser of choice.

1. Create the Heroku instance:
```bash
heroku create SampleProject
git push heroku master
heroku run rake db:migrate
heroku restart
```

1. Verify in your web browser: `http://sampleproject.herokuapp.com`

1. Set up Stripe and Google Analytics:
```bash
heroku config:set \
GOOGLE_ANALYTICS_DOMAIN=sampleproject.herokuapp.com \
GOOGLE_ANALYTICS_UA=UA-56346779-1 \
STRIPE_PUBLISHABLE_KEY=pk_zv4FnnuZ28LFHccVSajbQQaTxnaZl
STRIPE_SECRET_KEY=lbVrAG8WhPb2cHG9ryBBi1psT4ZREpm8
```

1. Add the free tier of SendGrid to enable user account emails:
```bash
heroku addons:add sendgrid:starter
```

1. Add pgbackups
```bash
h addons:add pgbackups pcr
```
Congratulations! Please email feedback to `derewecki@gmail.com`.
