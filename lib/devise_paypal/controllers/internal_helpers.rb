module DevisePaypal
  module Controllers
    module InternalHelpers
      private
        def handle_callback_action(resource_params)
          self.resource = resource_class.find_for_paypal_auth(resource_params)

          if resource.persisted? && resource.errors.empty?
            set_paypal_flash_message :notice, :success, :resource => resource
            sign_in_and_redirect resource_name, resource, :event => :authentication
          else
            clean_up_passwords(resource)
            render_for_paypal
          end
        end

        # Handles Paypal flash messages by adding a cascade. The default messages
        # are always in the controller namespace:
        #
        #   en:
        #     devise:
        #       paypal_permissions_authable:
        #         success: 'Successfully authorized from Paypal account'
        #
        #       paypal_authable:
        #         success: 'Successfully authorized from Paypal account.'
        #
        # But they can also be nested by Devise scope:
        #
        #   en:
        #     devise:
        #       paypal_permissions_authable:
        #         admin:
        #           success: 'Hello admin! You're successfully authorized from Paypal'
        #       paypal_authable:
        #         admin:
        #           sucess: 'Hello admin! You're successfully authorized from Paypal'
        #
        # If you customize your controllers by inheriting
        # Devise::PaypalPermissionsAuthable or Devise::PaypalAuthable
        # don't forget to change your translation key from
        # 'paypal_permissions_authable' => 'your paypal permissions controller' and
        # 'paypal_authable' => 'your paypal authable controller'
        #
        def set_paypal_flash_message(key, type, options={})
          set_flash_message(key, type, options)
        end

        # Choose which template to render when a not persisted resource is
        # returned in the find_for_paypal_auth.
        # By default, it renders registrations/new.
        def render_for_paypal
          render_with_scope :new, devise_mapping.controllers[:registrations]
        end
    end
  end
end

