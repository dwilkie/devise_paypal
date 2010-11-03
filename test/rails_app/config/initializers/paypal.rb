Paypal.setup do |config|
  config.environment = Rails.env.production? ? "live" : "sandbox"
  config.api_username = "Replace me with your api username"
  config.api_password = "Replace me with your api password"
  config.api_signature = "Replace me with your api signature"
end

