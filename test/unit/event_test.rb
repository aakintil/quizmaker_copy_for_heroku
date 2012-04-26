require 'test_helper'

class EventTest < ActiveSupport::TestCase
  
describe Event do
  it { should belong_to(:user)}
  it { should have_many(:quizzes)}
  
  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:num_quizzes)}
  
end

end
