# Introduction
Thanks for downloading JohnHenry, the fastest way to launch a new Ruby on
Rails web application on Heroku with Bootstrap. We'll have you up and running
in minutes!

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

1. Edit `Gemfile` and just below `rails` add:
   `gem 'johnhenry', git: 'https://johnhenryrails:A9S26gdLZz@bitbucket.org/johnhenryrails/johnhenry.git'`

1. Run `bundle` to update `Gemfile.lock`

1. Run JohnHenryRails installation script: `bundle exec rake johnhenry:install`

1. Commit the generated changes:

   ```bash
   git add app config Gemfile*
   git rm app/views/layouts/application.html.erb
   git commit -m 'Install JohnHenryRails'
   ```

1. Install database migrations and run them
```bash
bundle exec rake john_henry:install:migrations
bundle exec rake db:migrate
git add db && git commit -m 'Add initial migrations and schema.rb'
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

1. Add pgbackups and take your first database backup:
```bash
heroku addons:add pgbackups
heroku pgbackups:capture
```
You can additionally schedule daily backups with Heroku's Scheduler:
```bash
heroku addons:add scheduler
heroku addons:open scheduler
```

1. Set up a monitoring service. UptimeRobot.com gives you 50 free monitors.
   On Heroku, this has the added benefit of keeping your site active, so that
   your dyno never hibernates and you never get a slow request because the dyno
   was waking back up.

1. Set up a staging instance

1. (optional) Add a custom domain
`heroku domains:add www.johnhenryrails.com`
In your Registrar's host record configuration, you must add
`sampleproject.herokuapp.com.` as a CNAME for your domain.


Congratulations! Please email feedback to `derewecki@gmail.com`.
