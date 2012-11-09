module PlasticWrap
  module CardboardTube
    extend ActiveSupport::Concern

    included do
      include Rails.application.routes.url_helpers
      include ActionView::Helpers
      include Sprockets::Helpers::RailsHelper

      attr_accessor :options, :output_buffer
    end

    def initialize(wrappable, options={})
      super(wrappable)

      self.options = options
    end


    def model
      __getobj__
    end

    def config
      Rails.application.config.action_controller
    end

    def ==(obj)
      return true if obj.equal?(self)
      if obj.respond_to?(:__getobj__)
        self.__getobj__ == obj.__getobj__
      else
        self.__getobj__ == obj
      end
    end

    module ClassMethods
      def wrap(wrappable, options={})
        return wrappable if wrappable.instance_of? self

        if wrappable.respond_to?(:map)
          wrappable.map {|x| wrap(x, options) }
        else
          new(wrappable, options)
        end
      end
    end
  end
end
