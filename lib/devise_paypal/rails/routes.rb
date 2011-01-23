module ActionDispatch::Routing
  class Mapper
    protected
      def devise_paypal_authentication(mapping, controllers) #:nodoc:

        resources :paypal_authentications,
                  :only => [:new, :create, :show],
                  :controller => controllers[:paypal_authable],
                  :module => controllers[:paypal_authable] ? nil : 'devise'
      end
  end
end

