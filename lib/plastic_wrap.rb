require "plastic_wrap/version"

module PlasticWrap
  def self.create_wrap(superclass, base_wrap=Heavy)
    klass = Class.new(base_wrap)
    methods = superclass.instance_methods
    methods -= base_wrap.public_instance_methods
    methods -= [:to_s,:inspect,:=~,:!~,:===]

    klass.module_eval do
      methods.each do |method|
        define_method(method, Delegator.delegating_block(method))
      end
    end

    klass.define_singleton_method :public_instance_methods do |all=true|
      super(all) - superclass.protected_instance_methods
    end

    klass.define_singleton_method :protected_instance_methods do |all=true|
      super(all) | superclass.protected_instance_methods
    end

    # UGLY but simple form really likes to know about associations
    klass.define_singleton_method :reflect_on_association do |association|
      superclass.reflect_on_association(association)
    end

    return klass
  end
end
