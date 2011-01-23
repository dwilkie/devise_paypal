class Devise::PaypalAuthentication < ActiveRecord::Base
  include Paypal::Authentication
  attr_accessor :callback_url

  serialize :params

  validates :token,
            :uniqueness => true

  def get_authentication_token!
  end

  def remote_authentication_url
    #token.present? ? : self
  end
end

