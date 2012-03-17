require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Fluidruby do
  class Door
    extend Fluidruby

    state_machine do
      state :closed, :initial
      state :open
      state :broken

      on :open, transit_from: :closed, to: :open
      on :close, transit_from: :open, to: :closed
      on :break, transit_from: :closed, to: :broken
    end
  end

  let(:door) { Door.new }

  context 'state' do
    it 'defines states' do
      door.states.should =~ [:closed, :open, :broken]
    end

    it 'has an initial state' do
      door.initial_state.should == :closed
      door.state.should == :closed
    end
  end

  context 'event' do
    it 'creates a method with the same name' do
      [:open, :close, :break].each {|event| door.should respond_to event }
    end

    it 'change the state when an event is trigger' do
      door.state.should == :closed
      door.open
      door.state.should == :open
    end
  end
end

