# devise_paypal

devise_paypal is [Devise](http://github.com/plataformatec/devise) extension that allows you to authenticate users using the the [Paypal Permissions API](https://www.x.com/community/ppx/permissions) or the [Paypal Authentication API](https://www.x.com/community/ppx/authentication) through Devise.

## Installation

Add devise_paypal to your Gemfile and make sure your using Devise from the git repository or at least version: "1.2.rc"

    gem "devise", :git => "git://github.com/plataformatec/devise.git" # "1.2.rc"
    gem "devise_paypal" #, :git => "git://github.com/dwilkie/devise_paypal.git" # for the latest and greatest

Ensure your bundle is installed and run the generator
    bundle
    rails g devise_paypal:install

As the generator instructs, you need to also add paypal-ipn to your gemfile then run its generator

    gem 'paypal-ipn', :require => 'paypal' #, :git => "git://github.com/dwilkie/paypal.git" # for the latest and greatest

    bundle
    rails g paypal:initializer

This will create a configuration file where you can put your paypal api credentials.

Note: to enable the Paypal Permissions API you must file a ticket [here](https://www.paypal.com/mts). See this [page](https://www.x.com/community/ppx/permissions) for further details.

## Usage

### Model Configuration

Using the `devise` method, add `:paypal_authable` and/or `:paypal_permissions_authable` to your model.

    class User < ActiveRecord::Base
      devise paypal_authable, :paypal_permissions_authable
    end

### Views

If you have chosen a model named User and `devise_for :users` is already added to your config/routes.rb, devise_paypal will create the following url methods:

    new_user_paypal_authable
    new_user_paypal_permissions_authable

Then you only need to add them to your layouts in order to provide Paypal authentication:

    <%= link_to "Sign in with Paypal Authable", new_user_paypal_authable_path %>
    <%= link_to "Sign in with Paypal Permissions Authable", new_user_paypal_permissions_authable_path %>

By clicking on these links, the user will be redirected to Paypal. Then after entering their credentials, they'll be redirected back to your application.

### Model Callback Method

Implement a class method in your model called `find_for_paypal_auth` which accepts a single params hash argument. The params hash contains the information returned from Paypal in the following format:

    :email => "johnny@example.com",
    :first_name => "Johnny",
    :last_name => "Walker",
    :permissions => {
      :mass_pay => true
    }

The method should return a single record which will be used to sign in the user. A simple implementation may look like this:

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

Say you want to request permission to access a Paypal API on behalf of a user. You can do this by overriding the devise_for call in your routes.rb file.

    # routes.rb
    devise_for :users, :controllers => {
      :paypal_permissions_authable => "paypal_registrations"
    }

Then creating your own controller inheriting from: `Devise::PaypalPermisssionsAuthableController`

    # app/controllers/paypal_registrations_controller.rb
    class PaypalRegistrationsController < Devise::PaypalPermissionsAuthableController
      def new
        @permissions = {:mass_pay => true}
        super
      end
    end

In this case be sure to remember to modify the keys for your locale file:
    # config/locales/devise_paypal.en.yml
    en:
      devise:
        paypal_registrations:
          success: "Successfully authorized from paypal account."

By default, if a non-persisted record is returned by your model callback method, the user will be rendered the new registrations page from `devise :registrations`

To change this behavior simply override `render_for_paypal` in your controller

    # app/controllers/paypal_registrations_controller.rb
    class PaypalRegistrationsController < Devise::PaypalPermissionsAuthableController
      private

      def render_for_paypal
        render "welcome#index"
      end
    end

For more details check out the [source](https://github.com/dwilkie/devise_paypal/tree/master/lib/devise_paypal/)

## Trying Things Out

The gem comes with  [sample rails app](https://github.com/dwilkie/devise_paypal/tree/master/test/rails_app) so you can try things out in your browser. To start it:

    git clone git://github.com/dwilkie/devise_paypal.git
    cd devise_paypal/test/rails_app
    bundle
    rake db:migrate
    rails s

Then go to [http://localhost:3000](http://localhost:3000). Remember to replace the values in config/initializers/paypal.rb with your Paypal API credentials.



Copyright (c) 2010 David Wilkie, released under the MIT license

