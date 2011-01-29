class Devise::PaypalAuthentication < ActiveRecord::Base
  include Paypal::Authentication
  attr_accessor :callback_url

  serialize :params

  validates :token,
            :uniqueness => true,
            :allow_nil => true

  def get_authentication_token!(permissions = {})
    self.update_attributes!(
      :token => set_auth_flow_param!(callback_url).token
    )
  end

  def get_authentication_details!

  end

  def remote_url
    remote_authentication_url(token) if token.present?
  end

  def has_token_param?(query_params)
    @token_param = get_token_from_query_params(query_params)
  end

  def token_param_valid?
    @token_param == token
  end
end

