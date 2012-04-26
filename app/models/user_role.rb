class UserRole < ActiveRecord::Base
  attr_accessible :user_id, :role_id
    
  # Relationships
  # -----------------------------
  belongs_to :role
  belongs_to :user

  # Scopes
  # -----------------------------
  
  
  # Validations
  # -----------------------------
  validates_presence_of :role_id, :user_id
  
  
  # Other methods
  # -----------------------------    
  
  
end