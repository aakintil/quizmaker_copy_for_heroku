require 'test_helper'

class UserTest < ActiveSupport::TestCase

  describe User do
    it { should have_many(:user_roles) }
    it { should have_many(:questions) }
    it { should have_many(:roles) }
    it { should have_many(:events) }
  end

  def new_user(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:first_name] ||= 'Foo'
    attributes[:last_name] ||= 'Bar'
    attributes[:active] ||= true
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    user = User.new(attributes)
    user.valid? # run validations
    user
  end
  # 
  def setup
    User.delete_all
  end

  def test_valid
    assert new_user.valid?
  end

  def user_coach(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:first_name] ||= 'Foo'
    attributes[:last_name] ||= 'Bar'
    attributes[:active] ||= true
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]

    user = User.new(attributes)
    user.valid? # run validations
    # user.make_coach
    user  
  end

  def test_homepage
    role = Role.create!(:name => "Coach")
    approver = Role.create!(:name => "Approver")
    writer = Role.create!(:name => "Writer")
    two_role = Role.create!(:name => "Admin")
    
    # test for guest
    assert_equal("/", user_coach.homepage)
    
    # test for admin
    admin = User.create!(:username => "foo", :email =>"foo@example.com",
    :first_name => "Dooo", :last_name => "Baaaah", :password => "abc123")
    ur = UserRole.create(:user_id => admin.id, :role_id => two_role.id)
    ur.user = admin
    ur.save!
    assert_equal("/users", admin.homepage)
    
    # test for approver
    approv = User.create!(:username => "black", :email =>"black@example.com",
    :first_name => "Alex", :last_name => "Blacky", :password => "abc1dd23")
    app = UserRole.create(:user_id => approver.id, :role_id => approver.id)
    app.user = approv
    app.save!
    assert_equal("/questions/approver_index", approv.homepage)
    
    # test for writer
    write = User.create!(:username => "white", :email =>"white@example.com",
    :first_name => "Alex", :last_name => "Whitey", :password => "abcddd1dd23")
    app = UserRole.create(:user_id => write.id, :role_id => writer.id)
    app.user = write
    app.save!
    assert_equal("/questions/writer_index", write.homepage)
    
    #test for coach
    coa = User.create!(:username => "yellow", :email =>"yellow@example.com",
    :first_name => "Alex", :last_name => "Yellowy", :password => "adadsd23")
    app = UserRole.create(:user_id => coa.id, :role_id => role.id)
    app.user = coa
    app.save!
    assert_equal("/events/new", coa.homepage)
  end

  def test_is_coach
    assert_equal(false, user_coach.is_coach?)
  end

  def test_name
    assert_not_nil(user_coach.name)
  end

  def test_has_roles?
    assert_equal(false, user_coach.has_roles?)
  end

  def test_make_coach

    role = Role.create!(:name => "Coach")
    two_role = Role.create!(:name => "Approver")
    user = User.create!(:username => "foo", :email =>"foo@example.com",
    :first_name => "Dooo", :last_name => "Baaaah", :password => "abc123")
    ur = UserRole.create(:user_id => 15, :role_id => two_role.id)
    ur.user = user
    ur.save!
    assert_equal(true, user.make_coach)
  end

  def test_role?
    assert_equal(false, (user_coach.role? "Coach"))
  end
  
  def test_is_active?
    assert_equal(true, user_coach.is_active?)
  end
  
  
  def test_deactivate_user
    role = Role.create!(:name => "Coach")
    user = User.create(:username => "foo", :email =>"foo@example.com",
    :first_name => "Dooo", :last_name => "Baaaah", :password => "abc123", :active => false)
    ur = UserRole.create(:user_id => user.id, :role_id => role.id)
    ur.user = user
    user.save!
    ur.save!
    
    assert_equal(false, user.deactivate_user)
  end
  # # 
  # def test_deactivate_user
  #    assert_not_nil(user_coach.deactivate_user)
  #  end

  def test_require_username
    assert_equal ["can't be blank"], new_user(:username => '').errors[:username]
  end
  #  
  def test_require_first_name
    assert_equal ["can't be blank"], new_user(:first_name => '').errors[:first_name]
  end

  def test_require_last_name
    assert_equal ["can't be blank"], new_user(:last_name => '').errors[:last_name]
  end

  def test_require_password
    assert_equal ["can't be blank"], new_user(:password => '').errors[:password]
  end
  # 
  def test_require_well_formed_email
    assert_equal ["is invalid"], new_user(:email => 'foo@bar@example.com').errors[:email]
  end

  # def test_validate_uniqueness_of_email
  #   new_user(:email => 'bar@example.com').save!
  #   assert_equal ["has already been taken"], new_user(:email => 'bar@example.com').errors[:email]
  # end
  #     
  # def test_validate_uniqueness_of_username
  #   new_user(:username => 'uniquename').save!
  #   assert_equal ["has already been taken"], new_user(:username => 'uniquename').errors[:username]
  # end

  def test_validate_odd_characters_in_username
    assert_equal ["should only contain letters, numbers, or .-_@"], new_user(:username => 'odd ^&(@)').errors[:username]
  end

  def test_validate_password_length
    assert_equal ["is too short (minimum is 4 characters)"], new_user(:password => 'bad').errors[:password]
  end
  #  
  def test_require_matching_password_confirmation
    assert_equal ["doesn't match confirmation"], new_user(:password_confirmation => 'nonmatching').errors[:password]
  end

  # def test_generate_password_hash_and_salt_on_create
  #   user = new_user
  #   user.save!
  #   assert user.password_hash
  #   assert user.password_salt
  # end
  #      
  def test_authenticate_by_username
    User.delete_all
    user = new_user(:username => 'foobar', :password => 'secret')
     role = Role.create!(:name => "Coach")
      two_role = Role.create!(:name => "Approver")
      ur = UserRole.create(:user_id => user.id, :role_id => two_role.id)
      user.save!
      ur.user = user
      ur.save!
      
    assert_equal user, User.authenticate('foobar', 'secret')
  end
   
  #   def test_authenticate_by_email
  #     User.delete_all
  #     user = new_user(:email => 'foo@bar.com', :password => 'secret')
  #     user.save!
  #     assert_equal user, User.authenticate('foo@bar.com', 'secret')
  #   end
  #  
  #   def test_authenticate_bad_username
  #     assert_nil User.authenticate('nonexisting', 'secret')
  #   end

  # def test_authenticate_bad_password
  #    User.delete_all
  #    new_user(:username => 'foobar', :password => 'secret', :user_role => "Coach").save!
  #    assert_nil User.authenticate('foobar', 'badpassword')
  #  end
end
