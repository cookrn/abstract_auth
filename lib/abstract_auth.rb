# Requires
#require 'module_ext'
require "~/Developer/.rvm/gems/ruby-1.8.7-p302@abstract_auth/gems/module_ext-0.1.0/lib/module_ext/attribute_accessors.rb"

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

