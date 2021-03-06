module FluidrubyConfig
    class Environment
    attr_reader :states, :initial_state, :current_state

    def initialize
      @states = []
      @transitions = {}
      @initial_state = nil
    end

    def state(name, initial = nil)
      @states << name
      if initial
        if @initial_state
          raise InitialStateAlreadyExist,
            "You have already given an inital state"
        else
          @initial_state = name
          @current_state = name
        end
      end
    end

    def on(event, options)
      @transitions[event] = options
    end

    def events
      @transitions.keys
    end

    def event(event_name)
      if @current_state == @transitions[event_name][:transit_from]
        @current_state = @transitions[event_name][:to]
      else
        raise InvalidTransition,
          "Cannot transit from #{@current_state} to #{@transitions[event_name][:to]}"
      end
    end
  end

  class InvalidTransition < Exception; end

  class InitialStateAlreadyExist < Exception; end
end
