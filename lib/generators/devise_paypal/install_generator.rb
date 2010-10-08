module DevisePaypal
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Copies locale files to your application."

      def copy_locale
        copy_file "../../../config/locales/en.yml", "config/locales/devise_paypal.en.yml"
      end

      def show_readme
        readme "README" if behavior == :invoke
      end
    end
  end
end

