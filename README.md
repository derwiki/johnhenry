# Introduction
Thanks for downloading Rails4payment, the fastest way to launch a new Ruby on
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
Adams-MacBook-Pro:~/src/rails4payment[master *+%]
$ rails -v
Rails 4.0.2
```

1. Create a new Rails project:
   `rails new SampleProject && cd SampleProject`

1. Add to your `Gemfile`:
```ruby
gem 'rails4payment', '1.0.0',
    git: 'https://rails4payment:7eA9hsLSBw8Q@bitbucket.org/rails4payment/rails4payment.git'
gem 'haml-rails'
gem 'devise'
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'stripe'
gem 'meta-tags-helpers', '~> 0.2.0'
#
group :production do
  gem 'pg'
  gem 'rails_12factor'
end
#
group :development, :test do
  gem 'sqlite'
end
```

1. Run bundle to update Gemfile.lock and then create database:
```bash
bundle
bundle exec rake rails4payment:install:migrations
bundle exec rake db:migrate
```

1. Add to `config/routes.rb`
```ruby
root 'rails4payment/home#welcome'
devise_for :users, controllers: {
  registrations: 'rails4payment/registrations',
  sessions: 'rails4payment/sessions'
}
resources :payments, controller: 'rails4payment/payments'
```

1. Create `app/views/layouts/application.html.haml`:
```haml
!!!
%html
  %head
    = csrf_meta_tag
    = meta_tags
    = stylesheet_link_tag    'application', media: 'all'
    = javascript_include_tag 'application'
  %body
    %nav.navbar.navbar-default{role: "navigation"}
      / Brand and toggle get grouped for better mobile display
      .navbar-header
        %button.navbar-toggle{"data-target" => "#bs-example-navbar-collapse-1", "data-toggle" => "collapse", type: "button"}
          %span.sr-only Toggle navigation
          %span.icon-bar
          %span.icon-bar
          %span.icon-bar
        %a.navbar-brand{href: '/'} Rails 4 Payment
      / Collect the nav links, forms, and other content for toggling
      #bs-example-navbar-collapse-1.collapse.navbar-collapse
        %ul.nav.navbar-nav
          - if !signed_in?
            %li.active
              = link_to 'Sign Up', new_user_registration_path
            %li
              = link_to 'Sign In', new_user_session_path
        %form.navbar-form.navbar-left{role: "search"}
          .form-group
            %input.form-control{placeholder: "Search", type: "text"}/
          %button.btn.btn-default{type: "submit"} Search
        - if signed_in?
          %ul.nav.navbar-nav.navbar-right
            %li.dropdown
              %a.dropdown-toggle{"data-toggle" => "dropdown", href: "#"}
                Account
                %b.caret
              %ul.dropdown-menu
                %li
                  %a{ href: payments_path } Payments
                %li.divider
                %li
                  = link_to 'Sign Out', destroy_user_session_path, method: :delete

    - if notice.present? || alert.present?
      .container{ style: 'width: 100%' }
        .row
          - if notice.present?
            .col-md-12.alert.alert-success
              = notice
              %a.pull-right.dismiss-flash{ href: '#' } ✕
          - if alert.present?
            .col-md-12.alert.alert-warning
              = alert
              %a.pull-right.dismiss-flash{ href: '#' } ✕
    = yield

    - if Rails.env.production?
      :javascript
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

        ga('create', '#{ ENV['GOOGLE_ANALYTICS_UA'] }', '#{ ENV['GOOGLE_ANALYTICS_DOMAIN'] }');
        ga('send', 'pageview');
```

1. Remove the `erb` template: `rm app/views/layouts/application.html.erb`
   (Sorry about 5 and 6, they're definitely the worst kludges)

1. Add to `app/assets/stylesheets/application.css`:
```scss
*= require rails4payment/application
```

1. Add to `app/assets/javascript/application.js`:
```javascript
//= require rails4payment/application
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
Create `config/initializers/stripe.rb`:
```ruby
Stripe.api_key = ENV['STRIPE_SECRET_KEY']
STRIPE_PUBLISHABLE_KEY = ENV['STRIPE_PUBLISHABLE_KEY']
```

1. Add the free tier of SendGrid to enable user account emails:
```bash
heroku addons:add sendgrid:starter
```

Congratulations! Please email feedback to `derewecki@gmail.com`.
