class Devise::PaypalAuthenticationsController < ApplicationController
  include Devise::Controllers::InternalHelpers
  include DevisePaypal::Controllers::InternalHelpers

  # GET /resource/paypal_authentications/new
  def new
  end

  # POST /resource/paypal_authentications
  def create
    create_and_redirect_to_resource params
  end

  # GET /resource/paypal_authentications/:id
  def show
    @paypal_authentication = paypal_authentication_class.find_by_id(
      session[:paypal_authentication_id]
    )
    if @paypal_authentication
      if @paypal_authentication.token
        if @paypal_authentication.has_token_param?(params)
          if @paypal_authentication.token_param_valid?
            @paypal_authentication.get_authentication_details!
          else
            @paypal_authentication.destroy
            url = new_paypal_authentication_path(resource_name)
          end
        else
          url = @paypal_authentication.remote_url
        end
      end
    else
       set_flash_message(
         :error,
         :something_went_wrong_when_contacting_paypal
       ) if session[:paypal_authentication_id]
      url = new_paypal_authentication_path(resource_name)
    end
    redirect_to url if url
  end

  private
    def create_and_redirect_to_resource(params)
      paypal_authentication = paypal_authentication_class.create!(
        :params => params
      )
      session[:paypal_authentication_id] = paypal_authentication.id
      paypal_authentication.callback_url = paypal_authentication_url(
        resource_name, paypal_authentication
      )
      paypal_authentication.get_authentication_token!
      redirect_to paypal_authentication_path(
        resource_name, paypal_authentication
      )
    end
end

