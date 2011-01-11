module AbstractAuth

  def self.requires(*args)
    args.each do |required_api|
      raise AbstractAuth::Errors::MalformedRequirementError.new('You must define a requirement with a symbol!') unless required_api.is_a?(Symbol)
      @@requirements.push required_api
    end
  end

  def self.implement( requirement , &blk )
    raise AbstractAuth::Errors::MalformedImplementationError.new('You must define an implementation with a symbol!') unless requirement.is_a?(Symbol)
    @@implementations.merge!( { requirement => blk } )
  end

  def self.invoke( method , *args )
    raise AbstractAuth::Errors::NonRequiredImplementationCallError.new('The requested implementation was not required!') unless @@requirements.include?(method)
    raise AbstractAuth::Errors::NotImplementedError.new('The requirement was not implemented!') unless @@implementations.has_key?(method)
    @@implementations[method].call(args)
  end

end
