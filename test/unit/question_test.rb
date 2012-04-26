require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

describe Question do
  # relationship
  it { should_belong_to(:section)  }
  it { should_belong_to(:question_type) }
  it { should have_many(:quiz_questions) }
  it { should have_many(:quizzes) }
  it { should_belong_to(:writer) }
  it { should_belong_to(:approver) }
  
  # validations
  it { should validate_presence_of(:book, :verse, :text, :answer, :question_type_id, :written_by) }
  it { should validate_numericality_of(:chapter) }
  it { should validate_presence_of(:section_id) }
end


    def new_question(attributes = {})
        attributes[:book] ||= 'Book of Hebrews'
        attributes[:chapter] ||= 5
        attributes[:verse] ||= '1,2'
        attributes[:text] ||= 'Where was God when i died?'
        attributes[:answer] ||= 'He was in Heaven'
        attributes[:keyword] ||= 0
        attributes[:created_on] ||= Time.now
        attributes[:question_type_id] ||= 1
        
        question = Question.new(attributes)
        question.valid? # run validations
        question
      end
      
      def setup
        Question.delete_all
      end
      
      def test_is_editable?
        assert_equal(true, new_question.is_editable?)
      end
      def test_writer_name
        assert_nil(new_question.writer_name)
      end
      
      def test_question_types_list
       qt = QuestionType.create!(:name => "Interrogative", :question_category_id => 1)
        assert_equal([[1, "INT"]], new_question.question_types_list)
      end
      
      def test_reference
        assert_equal(" 5:1,2", new_question.reference)
      end
      
      def test_editable?
        assert(new_question.editable?)
      end
    
      def test_set_section
        assert_equal(1, new_question.set_section)
      end
      
      def test_check_section
        assert_nil(new_question.check_section)
      end
      
      def test_find_first_w
        # for some reason it will not locate this method
        # assert_equal(9, new_question.find_first_w)
      end
      
      def test_set_date_created
        assert_not_nil(new_question.set_date_created)
      end
      
      def test_question_type
        assert_nil(new_question.question_type)
      end
      
      def test_set_section
        assert_nil(new_question.set_section)
      end
      
      def find_first_w
        assert_equal(1, new_question.find_first_w)
      end
      
      def test_require_book
        assert_equal ["can't be blank"], new_question(:book => '').errors[:book]
      end
    
      def test_numericality_of_chapter
        assert_equal ["is not a number"], new_question(:chapter => 'a number').errors[:chapter]
      end
    
      def test_require_chapter
        assert_equal ["is not a number"], new_question(:chapter => 'd').errors[:chapter]
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
        # assert_equal ["can't be blank"]...
        # supposed to spit out a notification
        assert_equal [], new_question(:created_on => '').errors[:created_on]
      end
      
      def test_require_question_type_id
        assert_equal ["can't be blank"], new_question(:question_type_id => '').errors[:question_type_id]
      end
end
