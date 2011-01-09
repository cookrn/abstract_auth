# Requires
require 'module_ext'

module AbstractAuth

  # Autoloads
  autoload :Errors , 'abstract_auth/errors'

  # Requires
  require 'abstract_auth/abstract_auth'

  # Define our container to hold implemented APIs
  mattr_accessor :implementations
  @@implementations = {}

  # Define our container to hold APIs required to be implemented
  #mattr_accessor :requirements
  #@@requirements = []

  # Yield AbstractAuth on setup for fancy configuration
  def self.setup
    yield self
  end

end

