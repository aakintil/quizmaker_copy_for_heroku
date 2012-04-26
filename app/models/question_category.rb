class QuestionCategory < ActiveRecord::Base
  attr_accessible :name
    
  # Relationships
  # -----------------------------
  has_many :questions
  has_many :question_types
  
  # Constants
  # -----------------------------
  CATEGORY_ABBREVIATIONS = {'Interrogative' => 'INT', 'Finish The Verse' => 'FTV', 'Quote' => 'QT', 'Reference' => 'REF', 'Multiple Answer' => 'MA', 'Situation' => 'SIT'}

  # Scopes
  # -----------------------------
  
  
  # Validations
  # -----------------------------
  validates_presence_of :name
  
  # Other methods
  # -----------------------------    
  
  
end