class Ability
  include CanCan::Ability

  def initialize(user)
    
    # set user to new User if not logged in
    user ||= User.new # i.e., a guest user
    
    if user.is_admin?
      
      # Admins can do it all
      can :manage, :all
      
    elsif user.is_writer?
      
      ### User Abilities ###
        # Can edit their own profile
        can :show, User do |u|
          u.id == user.id
        end
        # Can update their own profile
        can :update, User do |u|
          u.id == user.id
        end

      ### Question Abilities ###
        # Can create questions
        can :create, Question
        # Can index and show questions written by them
        can :writer_index, Question
        can :show, Question do |q|
          q.written_by == user.id
        end
        # Cannot edit questions that are not yours or past Question::EDITABLE_PERIOD
        can :edit, Question do |q|
          q.editable? && q.written_by == user.id
        end
        can :update, Question do |q|
          q.editable? && q.written_by == user.id
        end
        # Can only destroy questions that are in the Question::EDITABLE_PERIOD
        can :destroy, Question do |q|
          q.editable? && q.written_by == user.id
        end
	  
      ### Quiz & Event Abilities ###
        # Can Generate Quizzes
        can :create, Event
        can :create, Quiz
        can :show, Event
        can :show, Quiz
        	  
	  
    elsif user.is_approver?
    
      ### User Abilities ###
        # Can edit their own profile
        can :show, User do |u|
          u.id == user.id
        end
        # Can update their own profile
        can :update, User do |u|
          u.id == user.id
        end
    
      ### Question Abilities ###
        # Can index and show questions
        can :approver_index, Question
        can :show, Question
        # Can edit questions only if they haven't written them
        can :edit, Question do |q|
          q.written_by != user.id
        end
        can :update, Question do |q|
          q.written_by != user.id
        end
        # Can delete questions
        can :destroy, Question


      ### Quiz & Event Abilities ###
        # Can Generate Quizzes
        can :create, Event
        can :create, Quiz
        can :show, Event
        can :show, Quiz
          
	  
    elsif user.is_coach?

      ### User Abilities ###
        # Can edit their own profile
        can :show, User do |u|
          u.id == user.id
        end
        # Can update their own profile
        can :update, User do |u|
          u.id == user.id
        end
        

      ### Quiz & Event Abilities ###
        # Can Generate Quizzes
        can :create, Event
        can :create, Quiz
        can :show, Event
        can :show, Quiz

	  
    else
      # Guests can sign-up
      can :create, User
      
      # Guests get nothing more
    end
    
    
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
