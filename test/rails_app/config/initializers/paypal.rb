Paypal.setup do |config|
  config.environment = Rails.env.production? ? "live" : "sandbox"
  config.api_username = ENV['PAYPAL_API_USERNAME'] || "Replace me with your api username"
  config.api_password = ENV['PAYPAL_API_PASSWORD'] || "Replace me with your api password"
  config.api_signature = ENV['PAYPAL_API_SIGNATURE'] || "Replace me with your api signature"
end

