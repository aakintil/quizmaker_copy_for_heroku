class Question < ActiveRecord::Base
  attr_accessible :written_by, :approved_by, :question_category_id, :question_type_id, :section_id, :book, :chapter, :verse, :text, :answer, :keyword, :created_on, :approved_on, :approval_level, :approval_reason, :position
  
  attr_accessible :question_type

  # Relationships
  # -----------------------------
  belongs_to :section
  belongs_to :question_category
  has_many :quiz_questions, :dependent => :destroy
  has_many :quizzes, :through => :quiz_questions
  
  belongs_to :writer, :class_name => "User", :foreign_key => "written_by"
  belongs_to :approver, :class_name => "User", :foreign_key => "approved_by"
  
  # Constants
  # ----------------------------
  QUESTION_TYPES = {'Interrogative' => 'INT', 'Finish The Verse' => 'FTV', 'Finish This' => 'FT', 'Finish These Two Verses' => 'FT2V', 'Finish This And The Next' => 'FTN', 'Quote' => 'QT', 'Quote These Two Verses' => 'Q2V', 'Chapter Only Reference' => 'CR', 'Chapter Verse Reference' => 'CVR', 'Chapter Reference Multiple Answer' => 'CRMA', 'Chapter Verse Reference Multiple Answer' => 'CVRMA', 'Multiple Answer' => 'MA', 'Situation' => 'SIT'}
  BOOKS = {"Hebrews" => "Heb.", "1 Peter" => "1Pet.", "2 Peter" => "2Pet."}
  BOOK_LIST =[["Hebrews", "Heb."],["1 Peter", "1Pet."],["2 Peter","2Pet."]]
  APPROVAL_LEVELS = {-1 => 'Refuse Approval', 0 => 'Not Set', 1 => 'Local', 2 => 'District', 3 => 'Local & District', 4 => 'International', 5 => 'Local & International', 6 => 'District & International', 7 => 'Local & District & International'}
  KEYWORD = {0 => "Not Set", 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5" }
  EDITABLE_PERIOD = 24.hours
  CHURCH = 1
  INTERNATIONAL = 4
  
  # Callbacks
  # ----------------------------
  before_create :set_date_created
  before_update :check_section
  #before_save :find_first_w
  #after_update :set_section
  
  # Scopes
  # -----------------------------
  
  # all questions ordered by most recently created
  scope :all, order("created_on desc")
  
  # questions written by a given writer
  scope :by_writer, lambda { |writer_id| where("written_by = ?", writer_id) }
  
  # questions not written by a given writer
  scope :not_written_by, lambda { |writer_id| where("written_by != ?", writer_id) }
  
  # all questions that can still be edited by their writers
  scope :writer_editable, where("created_on >= ?", DateTime.now - EDITABLE_PERIOD)
  
  # all questions submitted for approval that can no longer be edited by their writers
  #scope :approver_editable, where("created_on < ?", DateTime.now - EDITABLE_PERIOD)
  #scope :approver_editable, lambda { |user| where("created_on < ? and written_by != ?", DateTime.now - EDITABLE_PERIOD, user.id) }

  # all questions created at least 24 hours ago
  scope :awaiting_approval, where("created_on < ? AND approval_level IS NULL", DateTime.now - EDITABLE_PERIOD)
  
  scope :approved, where("approval_level >= ? AND approval_level <= ?", CHURCH, INTERNATIONAL)
  
  scope :pending, where("approval_level <= ? OR approval_level >= ?", CHURCH, INTERNATIONAL)
  
  # interrogative questions
  scope :int, where("question_category_id = ?", QuestionCategory.find_by_name("Interrogative").try(:id))
  
  # finish the verse questions
  scope :ftv, where("question_category_id = ?", QuestionCategory.find_by_name("Finish The Verse").try(:id))
  
  # quote questions
  scope :qt, where("question_category_id = ?", QuestionCategory.find_by_name("Quote").try(:id))
  
  # reference questions
  scope :ref, where("question_category_id = ?", QuestionCategory.find_by_name("Reference").try(:id))
  
  # multiple answer questions
  scope :ma, where("question_category_id = ?", QuestionCategory.find_by_name("Multiple Answer").try(:id))
  
  # situation questions
  scope :sit, where("question_category_id = ?", QuestionCategory.find_by_name("Situation").try(:id))

  
  
  # Validations
  # -----------------------------
  validates_presence_of :book, :verse, :text, :answer, :question_type_id, :written_by
  
  validates_numericality_of :chapter
  
  validates_presence_of :section_id, :if => :reference_set?, :message => 'Error:  This verse is not included in the material covered in Bible quizzing'
  
  # Other methods
  # -----------------------------
  
  def reference_set?
  	book != nil && chapter != nil && verse != nil
  end
  
  def writer_name
    writer.name if writer
  end

  # Returns true if this question is still editable by the writer
  def is_editable?
    self.created_on >= DateTime.now - EDITABLE_PERIOD
  end  

  # Sets the date the question was created to the current date
  def set_date_created
  	created_on = DateTime.now
  end
  
  def question_types_list
    question_types = QuestionType.all
    qt_list = []
    question_types.each do |qt|
      qt_list << [qt.id, QUESTION_TYPES[qt.name]]
    end
    return qt_list
  end
  
  # creates a virtual reference attribute
  def reference
  	"#{Question::BOOKS[book]} #{chapter}:#{verse}"
  end
  
  # determines if the question is editable
  def editable?
    # return (self.created_on >= DateTime.now - EDITABLE_PERIOD)
    # the commented out code makes unit tests work
    
    if (self.created_on.nil?)
            return false
          else
            return (self.created_on >= DateTime.now - EDITABLE_PERIOD)
          end
  end
  
  # gets the question's type
  def question_type
  	QuestionType.find_by_id(question_type_id)
  end
  
  # Set the section of this question based on its book, chapter, and verse
  def set_section
  	book = self.book
  	verse = self.verse.to_i
  	Section.all.each do |section|
  		if section.book == book && section.chapter == chapter && section.start_verse <= verse && section.end_verse >= verse
  			section_id = section.id
  			puts ""
			  return section_id
  		end
	  end
	  puts ""
  end
  
  def check_section
    return unless self.book_changed? || self.verse_changed? || self.chapter_changed?
    s_id = Section.find_by_book_and_chapter(self.book, self.chapter).try(:id)
    self.section_id = s_id
  end
 
  def find_first_w
    question = self.text.clone
    
    # Remove all punctuation and make lowercase
    question.gsub!(/[.,;:?!]/, '')
    question.downcase!

    # Get individual words of question
    words = question.split(' ')

    # Find location of first w -- TODO only find key 'w' words
    wordNumber = 1
    keywords = /^(when|where|why|w)/
    
    words.each do |word|
      if (match = word.match(keywords))
        break
      end
      wordNumber += 1
    end

    if wordNumber <= words.size
      self.keyword = wordNumber
    else
      self.keyword = 0
    end
  end
  
end
