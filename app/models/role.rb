class Role < ActiveRecord::Base
  attr_accessible :name

  # Relationships
  # -----------------------------
  has_many :user_roles, :dependent => :destroy

  # Scopes
  # -----------------------------
  
  
  # Validations
  # -----------------------------
  validates_presence_of :name
  
  
  # Other methods
  # -----------------------------    

  # Is this role an admin?
  def is_admin?
    self.name == "Admin"
  end

  # Is this role an writer?
  def is_writer?
    self.name == "Writer"
  end

  # Is this role an approver?
  def is_approver?
    self.name == "Approver"
  end
  
  # Is this role a coach?
  def is_coach?
    self.name == "Coach"
  end

end