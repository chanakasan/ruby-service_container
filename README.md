## ServiceContainer - a small dependency injection container

[![Gem Version](https://badge.fury.io/rb/service_container.svg)](http://badge.fury.io/rb/service_container)

**Installation**

`gem install service_container`

**Usage**

```
# instantiate a container
container = DI::ServiceContainer.new

# register a service
container.set(:my_logger) { MyLogger.new(log_level: :info, log_file: 'logs/test.log' }

# register a service with dependencies
container.set(:db_conn) do |c|
  DBConnection.new(
    host: 'localhost',
    user_name: 'my-user',
    password: 'my-pass',
    logger: c.get(:my_logger)
  )
end

# retrieve services in somewhere else
my_logger = container.get(:my_logger)
my_logger.log('something')

db_conn = container.get(:db_conn)
db_conn.query('somethiing')
```
