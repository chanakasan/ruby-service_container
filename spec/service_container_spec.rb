require_relative '../lib/service_container'

# test doubles
class MyLogger; end
class DBConnection
  def initialize(logger)
    @logger = logger
  end
end

RSpec.describe ServiceContainer do
  it 'instantiates without errors' do
    expect(subject).not_to be_nil
  end

  it 'registers a service' do
    subject.set(:logger) { MyLogger.new }

    expect(subject.get(:logger)).to be_kind_of(MyLogger)
  end

  it 'registers a service with dependencies' do
    subject.set(:logger) { MyLogger.new }
    subject.set(:db_connection) do |c|
      DBConnection.new(c.get(:logger))
    end

    expect(subject.get(:db_connection)).to be_kind_of(DBConnection)
  end
end
