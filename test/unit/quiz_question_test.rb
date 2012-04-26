require 'test_helper'

class QuizQuestionTest < ActiveSupport::TestCase
  
  describe QuizQuestion do
    # relationship
    it { should_belong_to(:quiz)  }
    it { should_belong_to(:question) }
  end
  
  def new_qq(attributes = {})
      attributes[:quiz_id] ||= 1
      attributes[:question_id] ||= 5
      attributes[:position] ||= 10
      
      qq = QuizQuestion.new(attributes)
      qq.valid? # run validations
      qq
    end
  
  def test_fill_position
    assert_nil(new_qq.fill_position)
  end
  
end
