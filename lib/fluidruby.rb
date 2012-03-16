module Fluidruby
  def state(name)
    @states ||= []
    @states << name
    states = @states
    module_eval do
      define_method(:states) { states }
    end
  end
end

