require 'github/markup'

class Johnhenry::HomeController < Johnhenry::ApplicationController
  before_filter :set_home_meta_tags

  def welcome
    title = 'New to Ruby on Rails? Launch a site like this in 10 minutes'
    description = <<-EOS.squish
      In under 10 minutes, watch your first web site go live to the internet!
      Save weeks of development time by building your next app on top of Rails
      4 Payment: ready to deploy on Heroku, included common front-end modules
      already built, accept payments with Stripe, Google Analytics integration
      and more!
    EOS
    if defined?(set_meta)
      set_meta title: title, description: description,
               og: { title: title, description: description }
    end
  end

  def install
    johnhenry_root = Gem.loaded_specs['johnhenry'].full_gem_path.freeze
    filename = File.join(johnhenry_root, 'README.md')
    @readme = GitHub::Markup.render(filename, File.read(filename))
  end

  private

    def set_home_meta_tags
      set_meta description: 'This will override the default description.',
               title: 'This title is overridden by set_meta in the controller action.'
    end
end
