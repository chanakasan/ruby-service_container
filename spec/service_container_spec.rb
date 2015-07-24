require_relative '../lib/di'

# test doubles
class MyLogger; end
class DBConnection
  def initialize(logger)
    @logger = logger
  end
end

RSpec.describe DI::ServiceContainer do
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

  it 'returns the same instance of a service' do
    subject.set(:logger) { MyLogger.new }
    logger1 = subject.get(:logger)
    logger2 = subject.get(:logger)

    expect(logger1).to eql(logger2)
  end
end
