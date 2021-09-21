module PlasticWrap
  module CardboardTube
    extend ActiveSupport::Concern

    puts '-- DEBUG plastic_wrap -- CardboardTube'
    puts '-- DEBUG plastic_wrap -- start included'

    included do
      puts '-- DEBUG plastic_wrap -- not logged -- inside cardboard_tube included'
      include Helpers
    end

    puts '-- DEBUG plastic_wrap -- end included'

    attr_accessor :options

    puts '-- DEBUG plastic_wrap -- initialize'

    def initialize(wrappable, options={})
      super(wrappable)

      self.options = options
    end

    puts '-- DEBUG plastic_wrap -- model'

    def model
      __getobj__
    end

    puts '-- DEBUG plastic_wrap -- =='

    def ==(obj)
      return true if obj.equal?(self)
      if obj.respond_to?(:__getobj__)
        self.__getobj__ == obj.__getobj__
      else
        self.__getobj__ == obj
      end
    end

    puts '-- DEBUG plastic_wrap -- use_mailer_config?'

    def use_mailer_config?
      options[:use_mailer_config]
    end

    puts '-- DEBUG plastic_wrap -- start module class methods'

    module ClassMethods

      puts '-- DEBUG plastic_wrap -- wrap'

      def wrap(wrappable, options={})
        return wrappable if wrappable.instance_of? self

        if wrappable.respond_to?(:map)
          wrappable.map {|x| wrap(x, options) }
        else
          wrap_type(wrappable).new(wrappable, options)
        end
      end

      puts '-- DEBUG plastic_wrap -- wrap_type'

      def wrap_type(wrappable)
        self
      end
    end

    puts '-- DEBUG plastic_wrap -- end module class methods'
  end
end
