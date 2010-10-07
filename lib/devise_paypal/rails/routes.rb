module ActionDispatch::Routing
  class Mapper
    protected
      def devise_paypal_authable(mapping, controllers) #:nodoc:
        path_names = {
          :new => mapping.path_names[:paypal_authorize_without_permissions],
        }

        resource :paypal_authable,
                 :only => :new,
                 :path => mapping.path_names[:registration],
                 :path_names => path_names,
                 :controller => controllers[:paypal_authable]

        get "/paypal_authable/callback",
          :to => controllers[:paypal_authable],
          :action => :callback_action,
          :as => :paypal_authable_callback
      end

      def devise_paypal_permissions_authable(mapping, controllers) #:nodoc:
        path_names = {
          :new => mapping.path_names[:paypal_authorize_with_permissions],
        }

        resource :paypal_permissions_authable,
                 :only => :new,
                 :path => mapping.path_names[:registration],
                 :path_names => path_names,
                 :controller => controllers[:paypal_permissions_authable]

        get "/paypal_permissions_authable/callback",
          :to => controllers[:paypal_permissions_authable],
          :action => :callback_action,
          :as => :paypal_permissions_authable_callback
      end
  end
end

