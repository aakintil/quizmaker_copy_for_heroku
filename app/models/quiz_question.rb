class QuizQuestion < ActiveRecord::Base
  # acts_as_list
	attr_accessible :quiz_id, :question_id, :position
	
	# Relationships
	# -----------------------
	belongs_to :quiz
	belongs_to :question
	
	
  # before_create :fill_position
	def fill_position
	 self.position = self.id
	end
	
  # scope :pos, order("position asc")
end
