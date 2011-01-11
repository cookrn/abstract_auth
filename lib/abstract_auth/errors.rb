module AbstractAuth

  module Errors

    class MalformedImplementationError < StandardError; end

    class MalformedRequirementError < StandardError; end

    class NonRequiredImplementationCallError < StandardError; end

    class NotImplementedError < StandardError; end

  end

end

