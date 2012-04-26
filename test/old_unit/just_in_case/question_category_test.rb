require 'test_helper'

class QuestionCategoryTest < ActiveSupport::TestCase

  should_belong_to :question_type
  
  def new_question_category(attributes = {})
    attributes[:name] ||= 'Reference'
    attributes[:question_type_id] ||= 1
    
    question_category = QuestionCategory.new(attributes)
    question_category.valid? # run validations
    question_category
  end
  
  def setup
    QuestionCategory.delete_all
  end

  def test_valid
    assert new_question_category.valid?
  end

  def test_require_name
    assert_equal ["can't be blank"], new_question_category(:name => '').errors[:name]
  end
  
  def test_require_question_type_id
    assert_equal ["can't be blank"], new_question_category(:question_type_id => '').errors[:question_type_id]
  end
end
