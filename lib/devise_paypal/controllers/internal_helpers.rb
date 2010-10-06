module DevisePaypal
  module Controllers
    module InternalHelpers
      protected
        # The callback redirect uri. Used to request the access token.
        def paypal_permissions_authable_callback_uri #:nodoc:
          paypal_permissions_authable_callback_url(resource_name)
        end

        def callback_action
          self.resource = resource_class.find_from_paypal_permissions(params[:token], signed_in_resource)

          if resource.persisted? && resource.errors.empty?
            set_paypal_flash_message :notice, :success
            sign_in_and_redirect resource_name, resource, :event => :authentication
          else
            session[paypal_permission_set_token] = params[:token]
            clean_up_passwords(resource)
            render_for_paypal
          end
        end
    end
  end
end

