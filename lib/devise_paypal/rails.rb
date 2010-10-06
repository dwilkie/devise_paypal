module DevisePaypal
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_controller) {
      include DevisePaypal::Controllers::UrlHelpers
    }

    def eager_load!
      mappings    = Devise.mappings.values.map(&:modules).flatten.uniq
      controllers = Devise::CONTROLLERS.values_at(*mappings)
      path        = paths.app.controllers.to_a.first
      matcher     = /\A#{Regexp.escape(path)}\/(.*)\.rb\Z/

      Dir.glob("#{path}/devise/{#{controllers.join(',')}}_controller.rb").sort.each do |file|
        require_dependency file.sub(matcher, '\1')
      end

      super
    end
  end
end

