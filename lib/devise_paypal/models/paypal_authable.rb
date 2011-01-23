module Devise
  module Models
    module PaypalAuthable
      extend ActiveSupport::Concern
      module ClassMethods
         Devise::Models.config(
           self, :paypal_authentication_class
         )
      end
    end
  end
end

