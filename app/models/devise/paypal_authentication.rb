class Devise::PaypalAuthentication < ActiveRecord::Base
  include Paypal::Authentication
  attr_accessor :callback_url

  serialize :params

  validates :token,
            :uniqueness => true

  def get_authentication_token!(permissions = {})
    self.update_attributes!(
      :token => set_auth_flow_param!(callback_url).token
    )
  end

  def remote_url
    remote_authentication_url(token) if token.present?
  end
end

