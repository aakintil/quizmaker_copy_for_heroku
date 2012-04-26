class Quiz < ActiveRecord::Base
	attr_accessible :interrogative, :finish_the_verse, :quote, :reference, :multiple_answer, :situation, :filename, :event_id, :question_categories, :section_ids
  # acts_as_list
  # Relationships
  # -----------------------------
	belongs_to :event
	has_many :quiz_sections, :dependent => :destroy
	has_many :sections, :through => :quiz_sections
	has_many :quiz_questions, :dependent => :destroy, :order => :position
	has_many :questions, :through => :quiz_questions
	has_one :user, :through => :event	
	
  # Constants
  # ----------------------------
  INT_RANGE = [8, 9, 10, 11, 12]
  FTV_RANGE = [2, 3]
  QT_RANGE = [1, 2]
  REF_RANGE = [3, 4, 5]
  MA_RANGE = [2, 3, 4, 5, 6, 7]
  SIT_RANGE = [0, 2, 3, 4]
  
  # Callbacks
  # ----------------------------
  after_create :append_filename, :make_quiz_questions
  
  
  # Scopes
  # ----------------------------
  
  # Validations
  # ----------------------------
  #validates_presence_of :event_id
  # validates_numericality_of :interrogative, :finish_the_verse, :quote, :reference, :multiple_answer, :situation
  #   validates_inclusion_of :interrogative, :in => INT_RANGE, :message => "must be 8-12"
  #   validates_inclusion_of :finish_the_verse, :in => FTV_RANGE, :message => "must be 2-3"
  #   validates_inclusion_of :quote, :in => QT_RANGE, :message => "must be 1-2"
  #   validates_inclusion_of :reference, :in => REF_RANGE, :message => "must be 3-5"
  #   validates_inclusion_of :multiple_answer, :in => MA_RANGE, :message => "must be 2-7"
  #   validates_inclusion_of :situation, :in => SIT_RANGE, :message => "must be 0, or 2-4"
  
  # validate :has_enough_questions
  # 
  #   def has_enough_questions
  #     errors.add(:base, "Quiz must have at least 20 questions") unless interrogative+finish_the_verse+quote+reference+multiple_answer+situation >= 20
  #   end
  
  # Other Methods
  # ----------------------------
  def append_filename	
		self.filename = "event#{self.event_id}quiz#{self.id}"
		self.save!
  end
  
  def make_quiz_questions
      	# generate the quiz
    	quiz_questions = self.generate_quiz()#interrogative, finish_the_verse, quote, reference, multiple_answer, situation)
    	
    	# create the QuizQuestion records
    	quiz_questions.each do |question|
    		new_quiz_question = QuizQuestion.new
    		new_quiz_question.question_id = question.id
    		new_quiz_question.quiz_id = self.id
    		new_quiz_question.save!
    	end
  end
  
  
  
  
  # ===== Quiz Generation =========
  
  # Sets the question_categories string for testing
  def set_question_categories
  	question_categories = ""
  end
	
	# Generates the specified number of valid quizzes
	def generate_quizzes
		self.event.num_quizzes.times {generate_quiz}
	end
	
	
	# Generates 1 valid quiz with a specified number of questions for each question category
	def generate_quiz()#int, ftv, qt, ref, ma, sit=0
		
		# FOR USE IN GOOD QUIZ GENERATION
		# 		if is_valid_size(int, ftv, qt, ref, ma, sit)
		# 		int = validate_range(int, 8, 12)
		# 		ftv = validate_range(ftv, 2, 3)
		# 		qt = validate_range(qt, 1, 2)
		# 		ref = validate_range(ref, 3, 5)
		# 		ma = validate_range(ma, 2, 7)
		# 		sit = validate_range(sit, 2, 4)
		
		# USED ON PREVIOUSLY WORKING VERSION OF QUIZ GEN
		# interrogative = int.to_i
		# 		finish_the_verse = ftv.to_i
		# 		quote = qt.to_i
		# 		reference = ref.to_i
		# 		multiple_answer = ma.to_i
		# 		situation = sit.to_i
		# 		num_questions = interrogative+finish_the_verse+quote+reference+multiple_answer+situation
		num_questions = 30
		
		num_int = 0
		num_ftv = 0
		num_qt = 0
		num_ref = 0
		num_ma = 0
		#num_sit = 0
		
		bonus_int = 0
		bonus_ftv = 0
		bonus_qt = 0
		bonus_ref = 0
		bonus_ma = 0
		#bonus_sit = 0
		quiz_questions = []
		question_ids = []
		self.question_categories = ""
	  
	  # if this quiz has no situation questions <== might not need this. we can just infer the number in the 'while' (currently 18) based on the sections included in the quiz
	  #if situation == 0
		# for first 20 questions
		while quiz_questions.length < 20
		  # roll a die, 1/3 or greater probability the question is an int	
		  #question = Question.new
		  rando = rand(6)
		  if rando == 0 || rando == 1
		  	question = Question.int[rand(Question.int.size)]
		  	puts "INT Question"
	  	  else
		  	question = Question.all[rand(Question.all.size)]
		  	puts "Any Question"
	  	  end
	  	  # ==== end of die roll =============================
	  	  
		  unless question_ids.include?(question.try(:id))
			category = question.question_category.name.downcase
			if category == "interrogative" && num_int < 12
				quiz_questions<<question
				question_ids<<question.id
				num_int += 1
				self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			elsif category == "finish the verse" && num_ftv < 3
				quiz_questions<<question
				question_ids<<question.id
				num_ftv += 1
				self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			elsif category == "quote" && num_qt < 2
				quiz_questions<<question
				question_ids<<question.id
				num_qt += 1
				self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			elsif category == "reference" && num_ref < 5
				quiz_questions<<question
				question_ids<<question.id
				num_ref += 1
				self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			elsif category == "multiple answer" && num_ma < 7
				quiz_questions<<question
				question_ids<<question.id
				num_ma += 1
				self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			# elsif category == "situation" && num_sit < 2
			# 				quiz_questions<<question
			# 				question_ids<<question.id
			# 				num_sit += 1
			# 				self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			end
		  end
		end
		
		
		
		# for last 10 questions
		while quiz_questions.length < num_questions
		  question = Question.all[rand(Question.all.size)]
		  unless question_ids.include?(question.id)
			category = question.question_category.name.downcase
			if category == "interrogative" && bonus_int < 4
				quiz_questions<<question
				bonus_int += 1
				question_ids<<question.id
		  	self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			elsif category == "finish the verse" && bonus_ftv < 1
				quiz_questions<<question
				bonus_ftv += 1
				question_ids<<question.id
		  	self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			elsif category == "quote" && bonus_qt < 1
				quiz_questions<<question
				bonus_qt += 1
				question_ids<<question.id
		  	self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			elsif category == "reference" && bonus_ref < 2
				quiz_questions<<question
				bonus_ref += 1
				question_ids<<question.id
		  	self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			elsif category == "multiple answer" && bonus_ma < 2
				quiz_questions<<question
				bonus_ma += 1
				question_ids<<question.id
		  	self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			# elsif category == "situation" && num_sit < situation
			# 				quiz_questions<<question
			# 				num_sit += 1
			# 				question_ids<<question.id
			# 		  	self.question_categories += "#{quiz_questions.length}: #{question.question_category.name}, "
			end
		  end
		end
		quiz_questions
	end #============================ END generate_quiz
	
	
	# Validates that the amount of questions specified lies within the legal range for a particular question type
	def validate_range(amount_of_category, lower_bound, upper_bound)
		if amount_of_category < lower_bound
			lower_bound
		elsif amount_of_category > upper_bound
			upper_bound
		else
			amount_of_category
		end
	end
	
	# Checks to see if the quiz contains a valid number of questions
	def is_valid_size?(int, ftv, qt, ref, ma, *sit)
		return int+ftv+qt+ref+ma+sit >=20 && int+ftv+qt+ma+sit <= 29
	end
  
  
  
  
end
