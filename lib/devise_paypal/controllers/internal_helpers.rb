module DevisePaypal
  module Controllers
    module InternalHelpers
      private
        def handle_callback_action(resource_params)
          self.resource = resource_class.find_for_paypal_auth(resource_params)

          if resource.persisted? && resource.errors.empty?
            set_paypal_flash_message :notice, :success
            sign_in_and_redirect resource_name, resource, :event => :authentication
          else
            clean_up_passwords(resource)
            render_for_paypal
          end
        end
    end
  end
end

