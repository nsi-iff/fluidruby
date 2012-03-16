require 'config'

module Fluidruby
  def state_machine(&machine_definition)
    env = FluidrubyConfig::Environment.new
    env.instance_eval &machine_definition
    module_eval do
      define_method(:states) { env.states }
    end
  end
end

