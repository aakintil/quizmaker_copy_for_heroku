#Factories for Quiz Maker
#=================================

  #Create factory for user class
  Factory.define :user do |u|
    u.first_name "Valid"
		u.last_name "User"
    u.username "vuser"
 		u.email "vuser@example.com"
    u.password	"secret"	
    u.password_confirmation { |a| a.password }
    u.active true
  end
  
  #Create factory for roles
  Factory.define :role do |r|
    r.name "Writer"
  end

  #Create factory for user_roles
  Factory.define :user_role do |ur|
    ur.association :user
    ur.association :role
  end

  #Create factory for question_categories
  Factory.define :question_category do |qc|
    qc.name "Interrogavite"
  end

  #Create factory for question_types
  Factory.define :question_type do |qt|
    qt.name "Quote"
    qt.association :question_category
  end

  #Create factory for questions
  Factory.define :question do |q|
    q.association :written_by
    q.association :question_category
    q.association :section
    q.question_type_id 1
    q.book "Hebrews"
    q.chapter 1
    q.verse "1"
    q.text "What is the meaning of life?"
    q.answer "42."
    q.keyword 1
  end
  
  #Create factory for sections
  Factory.define :section do |s|
    s.name "Section1"
    s.book "Hebrews"
    s.chapter 1
    s.start_verse "1"
    s.end_verse "2"
	end
