module ActionDispatch::Routing
  class Mapper
    protected
      def devise_paypal_registration(mapping, controllers) #:nodoc:
        path_names = {
          :new => mapping.path_names[:paypal_sign_up],
        }

        resource :paypal_registration,
                 :only => :new,
                 :path => mapping.path_names[:registration],
                 :path_names => path_names,
                 :controller => controllers[:paypal_registrations]
      end
  end
end

