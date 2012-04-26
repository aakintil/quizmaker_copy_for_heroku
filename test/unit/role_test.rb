require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  
  describe Role do
    # relationship
    it { should have_many(:user_roles)  }
      
    end

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
   
   def test_is_admin?
    assert new_role.is_admin?
   end
   
   def test_is_writer
    assert new_role(:name => "Writer").is_writer?
   end
   
   def test_is_approver?
     assert new_role(:name => "Approver").is_approver?
   end
   
   def test_is_coach?
     assert new_role(:name => "Coach").is_coach?
   end
 
 def notes
  # the LOOONG WAY of doing this
     #  
     # def coach(attributes = {})
     #   attributes[:name] ||= 'Coach'
     #   role = Role.new(attributes)
     #   role.valid?
     #   role
     # end
     # 
     # def approver(attributes = {})
     #  attributes[:name] ||= "Approver"
     #  role = Role.new(attributes)
     #  role.valid?
     #  role
     # end
     # 
     # def writer(attributes = {})
     #  attributes[:name] ||= "Writer"
     #  role = Role.new(attributes)
     #  role.valid?
     #  role
     # end
     # 
     # def admin(attributes = {})
     #  attributes[:name] ||= "Admin"
     #  role = Role.new(attributes)
     #  role.valid?
     #  role
     # end
 end 

end
