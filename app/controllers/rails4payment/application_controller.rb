class Rails4payment::ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :set_meta_tag_defaults

  DEFAULT_TITLE = 'Example Title'
  DEFAULT_DESCRIPTION =
    'This is the example description and should be overridden.'
  def set_meta_tag_defaults
    {
      title: DEFAULT_TITLE,
      description: DEFAULT_DESCRIPTION,
      language: 'english',
      viewport: 'width=device-width, initial-scale=1, maximum-scale=1',
      robots: 'index, follow',
      og: {
        title: DEFAULT_TITLE,
        description: DEFAULT_DESCRIPTION,
        image: 'http://placekitten.com/400/400',
        type: 'website' }
    }.tap do |meta_tags|
      # Set as ENV variables FB_ADMINS and FB_APP_ID
      %w(fb:admins fb:app_id).each do |fb_key|
        env_key = fb_key.upcase.sub(':', '_')
        if ENV[env_key].present?
          meta_tags[fb_key] = ENV[env_key]
        end
      end

      if defined?(set_meta)
        set_meta meta_tags
      end
    end
  end

  def admin_ids
    [1]
  end
end
