# ServiceContainer is used for registering services.
# It is also where the objects are stored.
#
# You may register a service by providing a name and a block used to create the service.
# i.e. set(:your_service_name) {...} method.
#
# Services may be retrieved by asking for them by name
# i.e get(:your_service_name) method.
#
class ServiceContainer
  # Thrown when a service cannot be located by name.
  MissingServiceError = Class.new(StandardError)

  # Thrown when a duplicate service is registered.
  DuplicateServiceError = Class.new(StandardError)

  def initialize
    @services = {}
  end

  # Registers a service named +name+.  The +block+ will be used to
  # create the service on demand.  It is recommended that symbols be
  # used as the name of a service.
  def set(name, &block)
    if @services[name]
      fail DuplicateServiceError, "A service already exists with name '#{name}'"
    end
    @services[name] = block
  end

  def get(name)
    service_block(name).call(self)
  end

  # Return the block that creates the named service.  Throw an
  # exception if no service creation block of the given name can be
  # found in the container
  def service_block(name)
    @services[name] || fail(MissingServiceError, "No service is registered with the name '#{name}'")
  end
end
