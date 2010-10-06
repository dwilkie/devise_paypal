require "devise"
require "paypal"

Devise.add_module :paypal_authable,
                  :controller => :paypal_authable,
                  :model => 'devise_paypal/models/paypal_authable',
                  :route => { :paypal_authable => [nil, :new] }

Devise.add_module :paypal_permissions_authable,
                  :controller => :paypal_permissions_authable,
                  :model => 'devise_paypal/models/paypal_permissions_authable',
                  :route => { :paypal_permissions_authable => [nil, :new] }

require 'devise_paypal/rails/routes'
require 'devise_paypal/rails'
require 'devise_paypal/controllers/url_helpers'
require 'devise_paypal/controllers/internal_helpers'

