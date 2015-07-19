require_relative '../lib/service_container'

RSpec.describe ServiceContainer do
  it 'instantiates without errors' do
    expect(subject).not_to be_nil
  end
end
