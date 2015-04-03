require File.expand_path('../boot', __FILE__)

# gem which rails/all
require 'active_record/railtie'
require 'action_controller/railtie'
# require 'action_view/railtie'
require 'action_mailer/railtie'
# require 'active_job/railtie'
require 'rails/test_unit/railtie'
# require 'sprockets/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Miao
  class Application < Rails::Application
    # remove none useful middleware
    config.middleware.delete ActionDispatch::Flash
    config.middleware.delete Rack::Sendfile
    config.middleware.delete ActionDispatch::Cookies
    config.middleware.delete ActionDispatch::Session::CookieStore

    config.before_initialize do
      ENV['SECRET_KEY_BASE'] = 'ea90abc1a9903eb258afedd97bf35b7f2fa399187a1ca5aa6208e499522513316c36e4d49d889e16467028c2d66b53b483d00a80ce32b8ba87cec13925e8f0ab'
    end

    config.generators do |g|
      g.orm             :active_record
      g.template_engine :erb
      # g.test_framework  :test_unit, fixture: false
      # g.test_framework  nil
      g.stylesheets     false
      g.javascripts     false
      g.jbuilder        false
      g.helper          false
    end

    config.i18n.available_locales = [:'zh-CN', :zh]
    config.i18n.default_locale = :'zh-CN'

    config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'
    config.encoding = 'utf-8'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths << Rails.root.join('lib')
  end
end
