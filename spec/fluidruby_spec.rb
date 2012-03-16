require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Fluidruby do
  context 'state' do
    class Door
      extend Fluidruby

      state_machine do
        state :unread, :initial
        state :read
        state :closed
      end
    end

    let(:door) { Door.new }

    it 'defines states' do
      door.states.should =~ [:unread, :read, :closed]
    end

    it 'has an initial state' do
      door.initial_state.should == :unread
      door.state.should == :unread
    end
  end
end

