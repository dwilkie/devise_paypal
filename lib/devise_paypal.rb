require "devise"
require "paypal"
Devise.add_module :paypal_registerable,
                  :controller => :paypal_registrations,
                  :model => 'devise_paypal/model',
                  :route => { :paypal_registration => [nil, :new] }

require "devise_paypal/paypal/internal_helpers"
require 'devise_paypal/rails/routes'
require 'devise_paypal/rails'

