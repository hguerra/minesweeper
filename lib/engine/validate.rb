module Engine
  class Validate
    def self.type(name, type, object)
      raise TypeError, "Incompatible types. Argument '#{name}' expected #{type}, got #{object.class}." unless object.is_a? type
    end

    def self.positive_argument(name, arg)
      raise ArgumentError, "Argument '#{name}' cannot be negative." if arg < 0
    end

    private_class_method :new
  end
end

