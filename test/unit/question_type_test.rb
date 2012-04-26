require 'test_helper'

class QuestionTypeTest < ActiveSupport::TestCase


describe QuestionType do
  it { should belong_to(:question_category)}
  it { should validate_presence_of(:name, :question_category_id)}
end


  def new_question_type(attributes = {})
      attributes[:name] ||= 'Multiple Answer'
      attributes[:question_category_id] ||= 1
      question_type = QuestionType.new(attributes)
      question_type.valid? # run validations
      question_type
    end
    
    def setup
      QuestionType.delete_all
    end
   
    def test_valid
      assert_equal(true, new_question_type.valid?)
    end
   
    def test_require_name
      assert_equal ["can't be blank"], new_question_type(:name => '').errors[:name]
    end
    
    def test_abbreviation
      assert_equal("MA", new_question_type.abbreviation)
    end
    
    def test_abbr_and_name
      assert_equal("MA - Multiple Answer", new_question_type.abbr_and_name)
      
    end
end
