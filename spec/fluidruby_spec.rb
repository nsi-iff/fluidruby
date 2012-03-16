require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Fluidruby do
  context 'state' do
    class Door
      extend Fluidruby

      state_machine do
        state :closed, :initial
        state :open
        state :broken

      end
    end

    let(:door) { Door.new }

    it 'defines states' do
      door.states.should =~ [:closed, :open, :broken]
    end

    it 'has an initial state' do
      door.initial_state.should == :closed
      door.state.should == :closed
    end
  end
end

