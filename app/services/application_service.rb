# Base service class to be inherited by all services

class ApplicationService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def call
    raise NotImplementedError
  end
end
