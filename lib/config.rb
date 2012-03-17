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

    def on(event, options)
      (@transitions ||= {})[event] = options
    end

    def events
      @transitions.keys
    end

    def event(event_name)
      if @current_state == @transitions[event_name][:transit_from]
        @current_state = @transitions[event_name][:to]
      end
    end
  end
end
