module FluidrubyConfig
  class Environment < BasicObject
    attr_reader :states, :initial_state, :current_state

    def state(name, initial = nil)
      (@states ||= []) << name
      if initial
        @initial_state = name
        @current_state = name
      end
    end
  end
end
