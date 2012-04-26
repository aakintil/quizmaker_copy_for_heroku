require 'test_helper'

class SectionTest < ActiveSupport::TestCase

  def new_section(attributes = {})
      attributes[:book] ||= 'Book of the Hebrews'
      attributes[:chapter] ||= 5
      attributes[:start_verse] ||= 2
      attributes[:end_verse] ||= 6
      
      section = Section.new(attributes)
      section.valid? # run validations
      section
    end
    
    def setup
      Section.delete_all
    end
  
    def test_valid
      assert new_section.valid?
    end
  
    def test_name
      assert_not_nil new_section.name
    end
    
    def test_numericality_of_chapter
      assert_equal ["is not a number"], new_section(:chapter => 'a number').errors[:chapter]
    end
  
    def test_require_book
      assert_equal ["can't be blank", "is not a number"], new_section(:chapter => '').errors[:chapter]
    end
  #   
    def test_numericality_of_start_verse
      assert_equal ["is not a number"], new_section(:start_verse => 'a number').errors[:start_verse]
    end
  
    def test_require_start_verse
      assert_equal ["can't be blank", "is not a number"], new_section(:start_verse => '').errors[:start_verse]
    end
      
    def test_numericality_of_end_verse
      assert_equal ["is not a number"], new_section(:end_verse => 'a number').errors[:end_verse]
    end
  # 
    def test_require_end_verse
      assert_equal ["can't be blank", "is not a number"], new_section(:end_verse => '').errors[:end_verse]
    end  
  #   
end
