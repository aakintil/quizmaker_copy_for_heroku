require 'test_helper'
require "cancan/matchers"
class AbilityTest < ActiveSupport::TestCase


  def new_user(attributes = {})
    attributes[:id] ||= 4
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:first_name] ||= 'Foo'
    attributes[:last_name] ||= 'Bar'
    attributes[:active] ||= true
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    user = User.create(attributes)
    user.valid? # run validations
    user
  end

  def setup
    User.delete_all
  end

  test "admin can manage all" do

    role = Role.create!(:id => "2", :name => "Admin")
    role.valid? # run validations
    user_role = UserRole.create!(:user_id => "1", :role_id => role.id)
    user_role.save!
    ability = Ability.new(role)
    assert ability.can?(:manage, :all)
  end

  test "what writer can do" do
    role = Role.create!(:id => "2", :name => "Writer")
    user_role = UserRole.create!(:user_id => new_user.id, :role_id => role.id)
    user_role.user = new_user
    new_user.update_roles

    ability = Ability.new(new_user)
    assert(ability.can?(:show, user_role.user))
    assert(ability.can?(:update, user_role.user))
    assert(ability.can?(:show, Question.new(:written_by => new_user)))
    assert(ability.cannot?(:edit, Question.new(:written_by => new_user.id)))
    assert(ability.cannot?(:update, Question.new(:written_by => new_user)))
    assert(ability.cannot?(:destroy, Question.new()))
    assert(ability.can?(:create, Event.new()))
    assert(ability.can?(:show, Event.new()))
    assert(ability.can?(:show, Quiz.new()))
    assert(ability.can?(:create, Quiz.new()))
  end

  test "what approver can do" do
    # you can do this two ways...by using new_user with a create method
    # as opposed to a new method
    # , or with just creating a brand new user
    user = User.create(:id => 1, :username => "foo", :email =>"foo@example.com",
    :first_name => "Dooo", :last_name => "Baaaah", :password => "abc123")
    role = Role.create!(:id => "1", :name => "Approver")
    user_role = UserRole.create!(:user_id => new_user.id, :role_id => role.id)
    user_role.user = new_user
    new_user.update_roles

    ability = Ability.new(new_user)
    assert(ability.can?(:show, user_role.user))
    assert(ability.can?(:update, user_role.user))
    assert(ability.cannot?(:edit, Question.new(:written_by => new_user)))
    assert(ability.cannot?(:update, Question.new(:written_by => new_user)))
    assert(ability.can?(:create, Event.new()))
    assert(ability.can?(:show, Question.new()))
    assert(ability.can?(:show, Quiz.new()))
    assert(ability.can?(:create, Quiz.new()))
  end

  test "what coaches can do" do
    role = Role.create!(:id => "1", :name => "Coach")
    user_role = UserRole.create!(:user_id => 4, :role_id => 1)
    user_role.user = new_user
    user_role.user.save
    user_role.user.update_roles
    ability = Ability.new(user_role.user)
    assert(ability.can?(:show, user_role.user)) 
    assert(ability.can?(:update, user_role.user)) 
  end


  test "guests can create stuff" do
    role = Role.create!(:id => "1", :name => "Guest")
    user_role = UserRole.create!(:user_id => new_user.id, :role_id => role.id)
    user_role.user = new_user
    new_user.update_roles

    ability = Ability.new(new_user)
    assert(ability.can?(:create, User.new()))
  end



end 