require 'test_helper'

class AbstractAuthTest < Test::Unit::TestCase

  def test_yields_self_on_setup
    AbstractAuth.setup do |config|
      assert_equal AbstractAuth , config
    end
  end

  def test_only_use_symbols_to_define_requirements
    begin
      AbstractAuth.setup do |config|
        config.requires "bad_def"
      end
    rescue AbstractAuth::Errors::MalformedRequirementError => e
      assert_equal 'You must define a requirement with a symbol!' , e.message
    end
  end

  def test_only_use_symbols_to_define_implementations
    begin
      AbstractAuth.implement "bad_def" do
        p "don't do this"
      end
    rescue AbstractAuth::Errors::MalformedImplementationError => e
      assert_equal 'You must define an implementation with a symbol!' , e.message
    end
  end

end

