require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  
  should_have_many :user_roles
  
  def new_role(attributes = {})
    attributes[:name] ||= 'Admin'
    
    role = Role.new(attributes)
    role.valid? # run validations
    role
  end
  
  def setup
    Role.delete_all
  end

  def test_valid
    assert new_role.valid?
  end

  def test_require_name
    assert_equal ["can't be blank"], new_role(:name => '').errors[:name]
  end
  
end
