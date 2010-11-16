# devise_paypal

devise_paypal is [Devise](http://github.com/dwilkie/devise_paypal) extension that allows you to authenticate users using the the Paypal Permissions API or the Paypal Authentication API through devise.

## Installation

Install devise_paypal and it's dependencies

    gem install devise_paypal

Add devise_paypal to your Gemfile and make sure your using devise from the git repository or at least version: "1.2.rc"

    gem "devise", :git => "git://github.com/plataformatec/devise.git" # "1.2.rc"
    gem "devise_paypal"

Ensure your bundle is installed and run the generator
    bundle install
    rails g devise_paypal:install

As the generator instructs you need to also add paypal-ipn to your gemfile and run it's generator

    gem 'paypal-ipn', :require => 'paypal'
    rails g paypal:initializer

This will create a configuration file where you can put your paypal api credientials.

Note: to enable the Paypal Permissions API you must file a ticket [here](https://www.paypal.com/mts). See this [page](https://www.x.com/community/ppx/permissions) for further details.

## Usage

### Model Configuration

Using the `devise` method, add the `paypal_authable` and/or `paypal_permissions_authable` to your model.

    class User < ActiveRecord::Base
      devise paypal_authable, :paypal_permissions_authable
    end

### Model Callback Method

Implement a class method in your model called `find_for_paypal_auth` which accepts a single params hash argument. The params hash contains the information returned from Paypal in the following format:

    :email => "johnny@example.com",
    :first_name => "Johnny",
    :last_name => "Walker",
    :permissions => {
      :mass_pay => true
    }

The method should return a single record which will be used to sign in the user. A simple implementation may look like:

    class User < ActiveRecord::Base
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

See [user.rb](https://github.com/dwilkie/devise_paypal/blob/master/test/rails_app/app/models/user.rb) in the [sample rails app](https://github.com/dwilkie/devise_paypal/tree/master/test/rails_app) for more details.

### Overriding Defaults



Copyright (c) 2010 David Wilkie, released under the MIT license

