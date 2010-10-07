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

end

