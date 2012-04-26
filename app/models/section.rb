class Section < ActiveRecord::Base
  attr_accessible :name, :book, :chapter, :start_verse, :end_verse
  
  # Relationships
  # -----------------------------
  has_many :questions, :dependent => :destroy
  has_many :quiz_sections, :dependent => :destroy
  has_many :quizzes, :through => :quiz_sections, :dependent => :destroy

  # Scopes
  # -----------------------------
  
  
  # Validations
  # -----------------------------
  validates_presence_of :book, :chapter, :start_verse, :end_verse
  validates_numericality_of :chapter, :start_verse, :end_verse
  
  # Other methods
  # -----------------------------    
  
  def name
  	"#{book} #{chapter}:#{start_verse}-#{end_verse}"
  end
  
  
end