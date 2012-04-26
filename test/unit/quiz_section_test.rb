require 'test_helper'

class QuizSectionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
describe QuizSection do
	it { should belong_to(:quiz) }
	it { should belong_to(:section) }  
end

end
