class Devise::PaypalAuthableController < ApplicationController
  prepend_before_filter :require_no_authentication, :only => :new
  include Devise::Controllers::InternalHelpers
  include Paypal::Authentication

  # GET /resource/paypal_authorize_without_permissions
  def new
    @permissions ||= {}
    redirect_to set_paypal_permissions_url(url_for(), permissions)
  end
end

