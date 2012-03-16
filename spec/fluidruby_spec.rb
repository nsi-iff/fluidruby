require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Fluidruby do
  context 'state' do
    class Door
      extend Fluidruby

      state_machine do
        state :unread
        state :read
        state :closed
      end
    end

    let(:door) { Door.new }

    it 'defines states' do
      door.states.should =~ [:unread, :read, :closed]
    end
  end
end

