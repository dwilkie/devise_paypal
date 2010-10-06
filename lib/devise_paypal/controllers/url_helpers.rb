module DevisePaypal
  module Controllers
    module UrlHelpers
      def paypal_authable_callback_url(resource_or_scope, *args)
        scope = Devise::Mapping.find_scope!(resource_or_scope)
        send("#{scope}_paypal_authable_callback_url", *args)
      end

      def paypal_permissions_authable_callback_url(resource_or_scope, *args)
        scope = Devise::Mapping.find_scope!(resource_or_scope)
        send("#{scope}_paypal_permissions_authable_callback_url", *args)
      end
    end
  end
end

