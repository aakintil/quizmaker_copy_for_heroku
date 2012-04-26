require 'test_helper'

class QuizTest < ActiveSupport::TestCase
  
  describe Quiz do
    it { should belong_to(:event) }
    it { should have_many(:quiz_sections) }
    it { should have_many(:sections) }
    it { should have_many(:quiz_questions) }
    it { should have_many(:questions) }
    it { should have_one(:user) }
    
    it { should validate_presence_of(:event_id) }
    it { should validate_numericality_of(:interrogative, :finish_the_verse, :quote, :reference, :multiple_answer, :situation) }
    it { should validate_inclusion_of(:interrogative) }
    it { should validate_inclusion_of(:finish_the_verse) }
    it { should validate_inclusion_of(:quote) }
    it { should validate_inclusion_of(:reference) }
    it { should validate_inclusion_of(:multiple_answer) }
    it { should validate_inclusion_of(:situation) }
    
  end
	
  def new_quiz(attributes = {})
       attributes[:interrogative] ||= '9'
       attributes[:finish_the_verse] ||= '3'
       attributes[:quote] ||= '2'
       attributes[:reference] ||= '3'
       attributes[:multiple_answer] ||= '7'
       attributes[:situation] ||= '0'
       attributes[:filename] ||= 'in_here'
       attributes[:event_id] ||= 4
       attributes[:question_categories] ||= '3'
       attributes[:section_ids] ||= ''
       
       quiz = Quiz.new(attributes)
       quiz.valid? # run validations
       quiz
     end
      #     
  def test_append_filename
    # doesn't really work. 
     # new_quiz.append_filename
     # assert_equal("event4quiz", new_quiz.append_filename)
  end
  
  def test_make_quiz_questions
    # assert_equal(true, new_quiz.make_quiz_questions)
    # assert_equal(true, new_quiz.generate_quizzes)
  end
  
  def test_has_enough_questions
    # assert_equal(true, new_quiz.has_enough_questions)
    error_msg = ["Quiz must have at least 20 questions",
     "Quiz must have at least 20 questions"]
    # assert_equal(error_msg, new_quiz(:quote => "0", :finish_the_verse => "0", :multiple_answer => "0").has_enough_questions)
  end
  
  def test_set_question_categories #called if for nil nonsense for these ones. 
    assert_equal("", new_quiz.set_question_categories)
  end
  
  def test_generate_quizzes
    event = Event.create!(:id => 4, :title => "new quiz", :num_quizzes => 5, :filename => "init", :user_id => 1, :quizzes_attributes => [])
    new_quiz(:event => event)
    # new_quiz.save
    # assert_equal(true, new_quiz.generate_quizzes)
  end
  
  def test_is_valid_size
     # assert_equal(true, new_quiz.is_valid_size?(1,2,3,4,5,6))
  end
  
  def test_validate_range
    assert_equal(3, new_quiz.validate_range(3,2,5)) #normal bound
    assert_equal(4, new_quiz.validate_range(3,4,5)) #lower bound
    assert_equal(5, new_quiz.validate_range(6,2,5)) #upper bound
  end
  
end
