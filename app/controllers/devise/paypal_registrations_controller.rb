class Devise::PaypalRegistrationsController < ApplicationController
  prepend_before_filter :require_no_authentication, :only => :new
  include Devise::Controllers::InternalHelpers
  include Paypal::Permissions

  # GET /resource/paypal_sign_up
  def new
    redirect_to set_paypal_permissions_url
  end
end

