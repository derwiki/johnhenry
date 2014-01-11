# Introduction
The JohnHenry Rails toolkit is meant to take care of all the menial tasks of
launching a Rails application, that are largely the same from application to
application. Using JohnHenry, you'll have the sample project live on a Heroku
subdomain of your choosing (e.g. `johnhenryrails.herokuapp.com`) in under ten
minutes, even if you don't know anything about Ruby on Rails!

Once you've launched your application, you can easily customize it to be a
landing page to collect emails for a new product. And when you've got a feature
you want users to pay for, JohnHenry's payment form is ready for you to use.

If you're already a Ruby on Rails expert, JohnHenry still provides value. It's
step 2 after `rails new MyProject`. Save 1-2 weeks of boilerplate development
setting up Bootstrap, Devise, Stripe, etc and concentrate on building the
product you want to build!

# Technologies Included
The following libraries and technologies are configured by JohnHenry and
work out of the box:
- Devise for user authentication / management
- Stripe (JS, Gem) for handling payments
- Bootstrap 3
- HAML
- SCSS
- jQuery
- Heroku-ready

# Screenshots and Demo
[![Screenshot](https://raw.github.com/derwiki/johnhenry/master/screenshot-johnhenry.jpg)](http://www.johnhenryrails.com)

A brand new Rails 4 project with *just* JohnHenry is live at:
[http://www.johnhenryrails.com](http://www.johnhenryrails.com)
This is exactly what you will end up with after installing.

# Installation screencast
Using the install script makes the process very easy. If you're still not
convinced, watch this video of launching a brand new JohnHenry installation
in under three minutes:
[![Screenshot](https://raw.github.com/derwiki/johnhenry/master/youtube-johnhenry-installation.jpg)](http://www.youtube.com/watch?v=CkjvOgzmC1M)

# Installation on Mac OS X
#### .. and probably Linux
All commands are run via Terminal, which you can find in your
Applications folder. If you're already using Terminal, try switching to iTerm
and see if you like it any better. Other version controls may work, but it's
assumed the user is using `git`. I build `git` from source using
[brew](http://brew.sh/).

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

1. Download and run the install script:
## Basic Installation
This assumes that you have the following commands available to you on your
command line: `rails`, `bundle`, `git`, `heroku`.
```bash
export projectname="MyWebSiteName"
curl https://raw.github.com/derwiki/johnhenry/master/install.sh | bash -
```
Congratulations, you've now made something on the internet! Be sure to tell
your mom.

## Extended / Optional Setup
1. Set up Google Analytics. You can sign up at:
`https://www.google.com/analytics/web/#management/Settings`

```bash
heroku config:set \
GOOGLE_ANALYTICS_DOMAIN=sampleproject.herokuapp.com \
GOOGLE_ANALYTICS_UA=UA-56346779-1
```
If you want to track signups as a goal in Analytics (a good baseline), set up
a goal where the goal URL is `/signup=1`, because after going through a new
user flow will drop you at that URL.

1. Google Webmaster Tools
After setting up Google Analytics, it's easy to link to Webmaster tools:
`https://www.google.com/webmasters/tools/home?hl=en`

1. Set up Stripe keys
```bash
heroku config:set \
STRIPE_PUBLISHABLE_KEY=pk_zv4FnnuZ28LFHccVSajbQQaTxnaZl \
STRIPE_SECRET_KEY=lbVrAG8WhPb2cHG9ryBBi1psT4ZREpm8
```

1. Add the free tier of SendGrid to enable user account emails:
```bash
heroku addons:add sendgrid:starter
heroku config:add BCC_EMAILS=you@example.com
```
Setting `BCC_EMAILS` will BCC the provided email with any email sent though
`JohnHenryMailer`.

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

1. Set up NewRelic
```
heroku addons:add newrelic:stark
echo "gem 'newrelic_rpm'" > Gemfile
bundle
curl https://gist.github.com/rwdaigle/2253296/raw/newrelic.yml > config/newrelic.yml
git add config/newrelic.yml Gemfile*
git commit -m "Set up NewRelic"
heroku config:set NEW_RELIC_APP_NAME="SampleProject"
git push heroku master
```

1. Set up Google Adwords tracking:
AdWord's support topic: `https://support.google.com/adwords/answer/1722054?hl=en`
[![Screenshot](https://raw.github.com/derwiki/johnhenry/master/gaw-setup-conversion-tracking.jpg)](https://support.google.com/adwords/answer/1722054?hl=en)
At the end of the flow, you'll get a code snippet:
![Screenshot](https://raw.github.com/derwiki/johnhenry/master/gaw-conversion-tracking.jpg)
The `google_conversion_id` and `google_conversion_label` are what we care about.
We're going to use those values to set environment variables that let our app
know what identifiers to send to AdWords:

```bash
heroku config:set GOOGLE_CONVERSION_ID=1234 GOOGLE_CONVERSION_LABEL='abc'
```

To verify that tracking is working properly, go through your sign up flow and
when you are dumped back on the homepage, view the page's source code. You
should see a `<!-- Google Code for signup Conversion Page -->` HTML comment
followed by the conversion snippet.

# Contributing
Bug fixes are welcome as pull requests against master. If you have bigger ideas,
please get in contact with me at `derewecki@gmail.com`.

# License
MIT License
