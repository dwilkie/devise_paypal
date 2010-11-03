class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :paypal_authable, :paypal_permissions_authable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def self.find_for_paypal_auth(params)
    if params
      user = self.find_or_initialize_by_email(params[:email])
      if user.new_record?
        stubbed_password = Devise.friendly_token[0..password_length.max-1]
        user.password = stubbed_password
        user.password_confirmation = stubbed_password
        user.save
      end
    else
      user = self.new
    end
    user
  end
end

