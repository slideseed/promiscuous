require 'set'

module DefineConstantMacros
  def define_constant(class_name, base = Object, &block)
    klass = Class.new(base)
    Object.const_set(class_name, klass)

    klass.class_eval(&block) if block_given?

    @defined_constants << class_name

    klass
  end
end

RSpec.configure do |config|
  config.before do
    @defined_constants = Set.new
  end

  config.after do
    @defined_constants.each do |class_name|
      Object.send(:remove_const, class_name)
    end
  end

  config.include DefineConstantMacros
end
