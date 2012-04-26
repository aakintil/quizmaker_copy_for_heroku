class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name, :active, :role_ids

  attr_accessor :password, :roles

  # Relationships
  # -----------------------------
  has_many :user_roles, :dependent => :destroy
  has_many :roles, :through => :user_roles
  has_many :questions
  has_many :events, :dependent => :destroy
  
  # Constants
  # -----------------------------
  # I don't think we need these for now -Vidur
  ROLES = { :admin => "Admin",
            :writer => "Writer",
            :approver => "Approver",
			:coach => "Coach"}

  # Callbacks
  # -----------------------------
  before_save :prepare_password, :activate_user
  after_create :make_coach, :send_welcome_email

  #after_save :update_roles
  #after_update :update_roles

  # Scopes
  # -----------------------------
  
  # Validations
  # -----------------------------
  validates_presence_of :username, :first_name, :last_name
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  
  # Other methods
  # -----------------------------
  
  # gets the user's name in "first_name last_name" format
  def name
    first_name + " " + last_name
  end
  
  # Updates the list of roles available to the user
  def update_roles
    userRoles = UserRole.find( :all, :conditions => ['user_id = ?', self.id] )
    @roles = userRoles.collect! { |user_role| Role.find(:first, :conditions => ['id = ?', user_role.role_id]).name }
    return true
  end
  
  # Returns an array or roles
  def roles
    self.update_roles
    @roles
  end
  
  def has_roles?
    self.roles.size > 0
  end
  
  # Returns true if authorized_role is one of this user's authorized roles
  def role? authorized_role
    self.update_roles
    
    if authorized_role.is_a? Symbol
      role_name = ROLES[authorized_role]
    else
      role_name = authorized_role
    end
    
    self.roles.include?(role_name)
  end
  
  # Is this user an admin?
  def is_admin?
    self.role? :admin
  end

  # Is this user an writer?
  def is_writer?
    self.role? :writer
  end

  # Is this user an approver?
  def is_approver?
    self.role? :approver
  end
  
  # Is this user a coach?
  def is_coach?
    self.role? :coach
  end
  
  # Make this user a coach
  def make_coach
  	user_coach = UserRole.new
  	user_coach.user_id = self.id
  	user_coach.role_id = Role.find_by_name("Coach").try(:id)
  	user_coach.save!
  end
  
  def is_active?
    return self.active
  end
  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end
  
  # Returns the homepage for this user depending on the role
  def homepage
    if self.is_admin?
      "/users"
    elsif self.is_approver?
      "/questions/approver_index"
    elsif self.is_writer?
      "/questions/writer_index"
    elsif self.is_coach?
      "/events/new"
    else
      "/"
    end
  end
  
  # Generates a random token
  def generate_token(token_name)
    begin
      self[token_name] = SecureRandom.urlsafe_base64 # random token
    end while User.exists?(token_name => self[token_name]) # makes sure it's unique
  end
  
  # Password reset
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  # Welcome Email
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  private unless 'test' == Rails.env

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
  
  def activate_user
    self.active = true
  end
  
  def deactivate_user
    self.active = false
  end
  
end