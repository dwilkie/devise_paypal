require 'active_support/core_ext/object/with_options'

Devise.with_options :model => true do |d|
  routes = [nil, :new]
  d.add_module :paypal_registerable, :controller => :paypal_registrations, :route => { :paypal_registration => routes }
end

