require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  should_belong_to :section
  should_belong_to :question_type
  
  def new_question(attributes = {})
    attributes[:book] ||= 'Book of Hebrews'
    attributes[:chapter] ||= 5
    attributes[:verse] ||= '1,2'
    attributes[:text] ||= 'Is 42 the answer to this question as well?'
    attributes[:answer] ||= 'Stack Overflow'
    attributes[:created_on] ||= Time.now
    attributes[:question_type_id] ||= 1
    
    question = Question.new(attributes)
    question.valid? # run validations
    question
  end
  
  def setup
    Question.delete_all
  end

  def test_valid
    assert new_question.valid?
  end

  def test_require_book
    assert_equal ["can't be blank"], new_question(:book => '').errors[:book]
  end

  def test_numericality_of_chapter
    assert_equal ["is not a number"], new_question(:chapter => 'a number').errors[:chapter]
  end

  def test_require_chapter
    assert_equal ["can't be blank", "is not a number"], new_question(:chapter => '').errors[:chapter]
  end
  
  def test_require_verse
    assert_equal ["can't be blank"], new_question(:verse => '').errors[:verse]
  end
  
  def test_require_text
    assert_equal ["can't be blank"], new_question(:text => '').errors[:text]
  end
  
  def test_require_answer
    assert_equal ["can't be blank"], new_question(:answer => '').errors[:answer]
  end
  
  def test_require_created_on
    assert_equal ["can't be blank"], new_question(:created_on => '').errors[:created_on]
  end
  
  def test_require_question_type_id
    assert_equal ["can't be blank"], new_question(:question_type_id => '').errors[:question_type_id]
  end
end
