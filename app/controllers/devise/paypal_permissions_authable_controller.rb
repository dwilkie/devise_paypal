class Devise::PaypalPermissionsAuthableController < ApplicationController
  prepend_before_filter :require_no_authentication, :only => :new
  include Devise::Controllers::InternalHelpers
  include DevisePaypal::Controllers::InternalHelpers
  include Paypal::Permissions

  # GET /resource/paypal_authorize_with_permissions
  def new
    @permissions ||= {}
    callback_url = paypal_permissions_authable_callback_uri
    redirect_to set_paypal_permissions_url(callback_url, @permissions)
  end

  # GET /resource/paypal_permissions_authable/callback
  def callback_action
    paypal_user_details = get_paypal_permissions(params[:token]) if params[:token]
    handle_callback_action(paypal_user_details, params)
  end

  private
    def paypal_permissions_authable_callback_uri(*args) #:nodoc:
      paypal_permissions_authable_callback_url(resource_name, *args)
    end
end

