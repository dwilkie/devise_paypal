require "devise"
require "paypal"

routes = [:new, nil]

Devise.add_module :paypal_authable,
                  :controller => "paypal_authentications",
                  :route => { :paypal_authentication => routes }

require 'devise_paypal/rails/routes'
require 'devise_paypal/rails'
require 'devise_paypal/models/paypal_authable'
require 'devise_paypal/controllers/internal_helpers'

