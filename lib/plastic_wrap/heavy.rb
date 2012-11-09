module PlasticWrap
  class Heavy < Delegator
    include PlasticWrap::CardboardTube

    def __getobj__  # :nodoc:
      @delegate_dc_obj
    end

    def __setobj__(obj)  # :nodoc:
      raise ArgumentError, "cannot delegate to self" if self.equal?(obj)
      @delegate_dc_obj = obj
    end
  end

end
