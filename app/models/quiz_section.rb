class QuizSection < ActiveRecord::Base
	attr_accessible :quiz_id, :section_id
	
  # Relationships
  # -----------------------------
	belongs_to :quiz
	belongs_to :section
	
  # Constants
  # ----------------------------
  
  # Callbacks
  # ----------------------------
  
  # Scopes
  # ----------------------------
  
  # Validations
  # ----------------------------
  
  # Other Methods
  # ----------------------------
end
