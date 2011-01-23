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
    @paypal_authentication = Devise::PaypalAuthentication.find_by_id(
      session[:paypal_authentication_id]
    )
    redirect_to @paypal_authentication ?
    @paypal_authentication.remote_authentication_url : :action => :new
  end

  private
    def create_and_redirect_to_resource(params)
      paypal_authentication = Devise::PaypalAuthentication.create!(
        :params => params
      )
      session[:paypal_authentication_id] = paypal_authentication.id
      paypal_authentication.callback_url = paypal_authentication_url(
        resource_name, paypal_authentication
      )
      paypal_authentication.get_authentication_token
      redirect_to paypal_authentication_path(
        resource_name, paypal_authentication
      )
    end
end

