require 'config'

module Fluidruby
  def state_machine(&machine_definition)
    env = FluidrubyConfig::Environment.new
    env.instance_eval &machine_definition
    module_eval do
      define_method(:states) { env.states }
      define_method(:initial_state) { env.initial_state }
      define_method(:state) { env.current_state }
      env.events.each {|event| define_method event }
    end
  end
end
