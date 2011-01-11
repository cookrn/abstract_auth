require 'test_helper'

class AbstractAuthTest < Test::Unit::TestCase

  def test_yields_self_on_setup
    AbstractAuth.setup do |config|
      assert_equal AbstractAuth , config
    end
  end

  def test_only_use_symbols_to_define_requirements
    assert_raise AbstractAuth::Errors::MalformedRequirementError do
      AbstractAuth.setup do |config|
        config.requires "bad_def"
      end
    end
  end

  def test_only_use_symbols_to_define_implementations
    assert_raise AbstractAuth::Errors::MalformedImplementationError do
      AbstractAuth.implement "bad_def" do
        p "don't do this"
      end
    end
  end

  def test_can_add_a_requirement
    AbstractAuth.setup do |config|
      config.requires :authenticated_user
    end
    assert AbstractAuth.requirements.include? :authenticated_user
  end

  def test_can_add_multiple_requirements
    AbstractAuth.setup do |config|
      config.requires :authenticated_user, :authenticated_admin
    end
    assert AbstractAuth.requirements.include? :authenticated_user
    assert AbstractAuth.requirements.include? :authenticated_admin
  end

  def test_can_add_implementation
    AbstractAuth.requires :authenticated_user
    AbstractAuth.implement :authenticated_user do
      TestUser.new
    end
    assert AbstractAuth.implementations.has_key? :authenticated_user
    assert AbstractAuth.implementations[:authenticated_user].is_a? Proc
  end

  def test_cannot_call_non_required_methods
    assert_raise AbstractAuth::Errors::NonRequiredImplementationCallError do
      AbstractAuth.invoke :not_required_method
    end
  end

  def test_cannot_call_non_implemented_methods
    assert_raise AbstractAuth::Errors::NotImplementedError do
      AbstractAuth.requires :a_sample_method
      AbstractAuth.invoke :a_sample_method
    end
  end

  def test_can_invoke_requirement
    AbstractAuth.requires :authenticate_user
    AbstractAuth.implement :authenticate_user do |user_id,password|
      return TestUser.new(user_id,password)
    end
    new_user = AbstractAuth.invoke( :authenticate_user , 'ronald' , 'macdonald' )
    assert new_user.is_a? TestUser
    assert_equal 'ronald' , new_user.username
    assert_equal 'macdonald' , new_user.password
  end

end

class TestUser
  def initialize(username,password)
    @username = username
    @password = password
  end
  def username
    @username
  end
  def password
    @password
  end
end

