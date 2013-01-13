Rubyjobs2::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.compile = false
  config.assets.digest = true
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  
  ActionMailer::Base.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address        => "smtp.gmail.com",
    :port           => 587,
    :domain         => "jobs@rubyjobs.ie",
    :user_name      => "jobs@rubyjobs.ie",
    :authentication => :plain,
    :password       => ENV['GMAIL_PASSWORD']
  }
end
