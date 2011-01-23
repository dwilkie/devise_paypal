class Devise::PaypalAuthentication < ActiveRecord::Base
  class GetPaypalAuthenticationTokenJob < Struct.new(:id, :callback_url)
    include Paypal::Authentication
    def perform
      authenticate_with_paypal_url(callback_url)
    end
  end

  attr_accessor :callback_url

  serialize :params

  validates :token,
            :uniqueness => true

  def get_authentication_token
    Delayed::Job.enqueue(
      GetPaypalAuthenticationTokenJob.new(id, callback_url), :priority => 5
    )
  end
end

