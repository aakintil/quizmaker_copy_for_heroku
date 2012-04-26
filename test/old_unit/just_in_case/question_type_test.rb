require 'test_helper'

class QuestionTypeTest < ActiveSupport::TestCase

  def new_question_type(attributes = {})
    attributes[:name] ||= 'Chapter Reference'
    
    question_type = QuestionType.new(attributes)
    question_type.valid? # run validations
    question_type
  end
  
  def setup
    QuestionType.delete_all
  end

  def test_valid
    assert new_question_type.valid?
  end

  def test_require_name
    assert_equal ["can't be blank"], new_question_type(:name => '').errors[:name]
  end

end
