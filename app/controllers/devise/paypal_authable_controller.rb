class Devise::PaypalAuthableController < ApplicationController
  prepend_before_filter :require_no_authentication, :only => :new
  include Devise::Controllers::InternalHelpers
  include DevisePaypal::Controllers::InternalHelpers
  include Paypal::Authentication

  # GET /resource/paypal_authorize_without_permissions
  def new
    callback_url = paypal_authable_callback_uri
    redirect_to authenticate_with_paypal_url(callback_url)
  end

  # GET /resource/paypal_authable/callback
  def callback_action
    paypal_user_details = get_auth_details(params[:token]) if params[:token]
    handle_callback_action(paypal_user_details)
  end

  private
    def paypal_authable_callback_uri(*args) #:nodoc:
      paypal_authable_callback_url(resource_name, *args)
    end
end

