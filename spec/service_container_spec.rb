require_relative '../lib/service_container'

class MyLogger; end

RSpec.describe ServiceContainer do
  it 'instantiates without errors' do
    expect(subject).not_to be_nil
  end

  it 'registers a service' do
    subject.set(:logger) { MyLogger.new }

    expect(subject.get(:logger)).to be_kind_of(MyLogger)
  end
end
