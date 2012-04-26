require 'test_helper'

class UserRoleTest < ActiveSupport::TestCase
  
  describe UserRole do
    
    it { should belong_to(:role) }
    it { should belong_to(:user) }
  end
  
   def new_user_role(attributes = {})
     attributes[:role_id] ||= 1
     attributes[:user_id] ||= 2
         
     user_role = UserRole.new(attributes)
     user_role.valid? # run validations
     user_role
   end
  #  
   def setup
     UserRole.delete_all
   end
  
   def test_valid
     assert new_user_role.valid?
   end
  # 
   def test_require_user_id
     assert_equal ["can't be blank"], new_user_role(:user_id => '').errors[:user_id]
   end
  
   def test_require_role_id
     assert_equal ["can't be blank"], new_user_role(:role_id => '').errors[:role_id]
   end
  
end
