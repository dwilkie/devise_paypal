require "devise"
require "paypal"

routes = [nil, :new]

module Devise
  # The paypal authentication model
  mattr_accessor :paypal_authentication_class
  @@paypal_authentication_class = "Devise::PaypalAuthentication"
end

Devise.add_module :paypal_authable,
                  :model => "devise_paypal/models/paypal_authable",
                  :controller => "paypal_authentications",
                  :route => { :paypal_authentication => routes }

require 'devise_paypal/rails/routes'
require 'devise_paypal/rails'
require 'devise_paypal/controllers/internal_helpers'

