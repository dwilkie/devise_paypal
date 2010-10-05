class Devise::OauthCallbacksController < ApplicationController
  include Devise::Controllers::InternalHelpers
  include Devise::Paypal::InternalHelpers
end

