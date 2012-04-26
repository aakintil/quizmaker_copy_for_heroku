class QuestionType < ActiveRecord::Base
  attr_accessible :name, :question_category_id
  
  # Relationships
  # -----------------------------
  belongs_to :question_category
  
  # Constants
  #-------------------------------
  QUESTION_TYPES = {'Interrogative' => 'INT', 'Finish The Verse' => 'FTV', 'Finish This' => 'FT', 'Finish These Two Verses' => 'FT2V', 'Finish This And The Next' => 'FTN', 'Quote' => 'QT', 'Quote These Two Verses' => 'Q2V', 'Chapter Only Reference' => 'CR', 'Chapter Verse Reference' => 'CVR', 'Chapter Reference Multiple Answer' => 'CRMA', 'Chapter Verse Reference Multiple Answer' => 'CVRMA', 'Multiple Answer' => 'MA', 'Situation' => 'SIT'}

  # Scopes
  # -----------------------------
  

  # Validations
  # -----------------------------
  validates_presence_of :name, :question_category_id
  
  # Other methods
  # -----------------------------    
  def abbreviation
  	QUESTION_TYPES[name]
  end
  
  def abbr_and_name
    abbreviation + " - " + name
  end
end