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

end
