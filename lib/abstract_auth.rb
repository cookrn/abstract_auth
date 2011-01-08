module AbstractAuth

  # Yield AbstractAuth on setup for fancy configuration
  def setup
    yield self
  end

end

