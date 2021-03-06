Devise.setup do |config|

# If using rails-api, you may want to tell devise to not use ActionDispatch::Flash
  # middleware b/c rails-api does not include it.
  # See: http://stackoverflow.com/q/19600905/806956
  config.navigational_formats = [:json]
  config.secret_key = ENV['DEVISE_KEY']
  config.password_length = 8..72
end
