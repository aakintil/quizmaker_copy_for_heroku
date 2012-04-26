class Event < ActiveRecord::Base
  attr_accessible :title, :num_quizzes, :filename, :user_id, :quizzes_attributes
	
  # Relationships
  # -----------------------------
	belongs_to :user
	has_many :quizzes, :dependent => :destroy
	
	accepts_nested_attributes_for :quizzes#, :reject_if => lambda { |quiz| quiz[:interrogative].blank? || quiz[:finish_the_verse].blank? || quiz[:quote].blank? || quiz[:reference].blank? || quiz[:multiple_answer].blank? }
	
  # Constants
  # ----------------------------
  
  # Callbacks
  # ----------------------------
  
  # Scopes
  # ----------------------------
  scope :all, order("created_at desc")
  
  # Validations
  # ----------------------------
  validates_presence_of :title
  validates_numericality_of :num_quizzes, :greater_than => 0, :less_than => 31
  
  # Other Methods
  # ----------------------------  
end
