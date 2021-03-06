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
  let(:window) do
    class Window
      extend Fluidruby

      state_machine do
        state :closed, :inital
        state :open, :initial
      end
    end
  end

  context 'state' do

    it "can't give more than one initial state" do
      lambda { window }.should raise_error FluidrubyConfig::InitialStateAlreadyExist
    end

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
      door.close
      door.state.should == :closed
    end

    it 'raises exception when transtion is invalid' do
      lambda { door.close }.should raise_error FluidrubyConfig::InvalidTransition, 'Cannot transit from closed to closed'
    end
  end
end

