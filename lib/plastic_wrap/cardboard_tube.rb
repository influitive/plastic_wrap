module PlasticWrap
  module CardboardTube
    extend ActiveSupport::Concern

    included do
      include Helpers
    end

    attr_accessor :options

    def initialize(wrappable, options={})
      super(wrappable)

      self.options = options
    end


    def model
      __getobj__
    end

    def ==(obj)
      return true if obj.equal?(self)
      if obj.respond_to?(:__getobj__)
        self.__getobj__ == obj.__getobj__
      else
        self.__getobj__ == obj
      end
    end

    def use_mailer_config?
      options[:use_mailer_config]
    end

    module ClassMethods
      def wrap(wrappable, options={})
        return wrappable if wrappable.instance_of? self

        if wrappable.respond_to?(:map)
          wrappable.map {|x| wrap(x, options) }
        else
          wrap_type(wrappable).new(wrappable, options)
        end
      end

      def wrap_type(wrappable)
        self
      end
    end
  end
end
