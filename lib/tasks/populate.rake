namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    # Generates fake data
    require 'faker'
    
    # Step 1: clear any old data in the db
    [Question, QuestionType, QuestionCategory, Section, User, UserRole, Role].each(&:delete_all)
    
    
    # Step 2: add default admins and roles - ProfH, Vidur, David, Xun, Dominic, Hannah, Faiz
    # Step 2a: Create roles
    roles = ["Admin", "Writer", "Approver", "Coach"]
    roles.each do |role_name|
      role = Role.new
      role.name = role_name
      role.save!
    end
    
    # Commonly used roles
    ADMIN_ROLE = Role.find(:first, :conditions => ['name = ?', 'Admin'])
    WRITER_ROLE = Role.find(:first, :conditions => ['name = ?', 'Writer'])
    APPROVER_ROLE = Role.find(:first, :conditions => ['name = ?', 'Approver'])
    COACH_ROLE = Role.find(:first, :conditions => ['name = ?', 'Coach'])
    
    
    # Step 2b: Create users
    members = [["Professor", "Heimann", "profh@cmu.edu", "profh", "star_tr3k"],
              ["Vidur", "Murali", "vidur.murali@gmail.com", "vidur", "secret"],
              ["David", "Songer", "cdsonger@andrew.cmu.edu", "david", "secret"],
              ["Xun", "Wang", "xunw@andrew.cmu.edu", "xun", "secret"],
              ["Dominic", "Leone", "dleone@andrew.cmu.edu", "dominic", "secret"],
              ["Hannah", "Gilchrist", "hgilchri@andrew.cmu.edu", "hannah", "secret"],
              ["Faiz", "Abbasi", "fabbasi@andrew.cmu.edu", "faiz", "secret"],
              ["Derin", "Akintilo", "aakintil@andrew.cmu.edu", "derin", "secret"]]
    
    dummies = [["Ernest", "Hemmingway", "ehemmingsTheMan@example.com", "writer", "secret"],
               ["Alex", "Trebek", "atrebek@example.com", "approver", "secret"],
               ["Mr", "Coach", "theCoach@example.com", "coach", "secret"]]
               
    # Array of Project Members' User objects
    project_members = []
    
    # Array of dummy accounts' User objects
    the_dummies = []
    
    members.each do |member|
      admin = User.new
      admin.first_name = member[0]
      admin.last_name = member[1]
      admin.email = member[2]
      admin.username = member[3]
      admin.password = member[4]
      admin.password_confirmation = member[4]
      admin.active = true
      admin.save!
      project_members << admin
    end
    
    dummies.each do |member|
      dummy = User.new
      dummy.first_name = member[0]
      dummy.last_name = member[1]
      dummy.email = member[2]
      dummy.username = member[3]
      dummy.password = member[4]
      dummy.password_confirmation = member[4]
      dummy.active = true
      dummy.save!
      the_dummies << dummy
    end
        
    # Step 2c: Add all the roles to every project member
    # ( The Coach role is added automatically by the after_save callback when the user is created )
    project_members.each do |user|
      
      # Make this user an admin
      userRole = UserRole.new    
      userRole.user_id = user.id
      userRole.role_id = ADMIN_ROLE.id
      userRole.save!

      # Make this user a writer
      userRole = UserRole.new
      userRole.user_id = user.id
      userRole.role_id = WRITER_ROLE.id
      userRole.save!
      
      # Make this user an approver
      userRole = UserRole.new
      userRole.user_id = user.id
      userRole.role_id = APPROVER_ROLE.id
      userRole.save!
      
    end
    
    # Step 2d : Link the dummies to their respective roles
    
    hemmingway = the_dummies[0]
    ur = UserRole.new
    ur.user_id = hemmingway.id
    ur.role_id = WRITER_ROLE.id
    ur.save!
    
    approver = the_dummies[1]
    ur = UserRole.new
    ur.user_id = approver.id
    ur.role_id = APPROVER_ROLE.id
    ur.save!
    
    coach = the_dummies[2]
    ur = UserRole.new
    ur.user_id = coach.id
    ur.role_id = COACH_ROLE.id
    ur.save!
    
    ### -- Stuff I'm still testing [Vidur]
    #Update all users
    #User.all.each do |user|
    #  user.save!
    #end
        
    # Step 3: add some sections to work with
    sectionNumber = 1
    Section.populate 13 do |section|
      section.name = "Section" + sectionNumber.to_s
      
      section.book = "Hebrews"
      section.chapter = sectionNumber

      section.start_verse = 1
      section.end_verse = [3,5,7,8,9]
      
      sectionNumber += 1
    end
    
    sectionChapter = 1
    Section.populate 5  do |section|
      section.name = "Section" + sectionNumber.to_s
      
      section.book = "1 Peter"
      section.chapter = sectionChapter

      section.start_verse = 1
      section.end_verse = [3,5,7,8,9]
      
      sectionNumber += 1
      sectionChapter += 1
    end
    
    sectionChapter = 1
    Section.populate 3  do |section|
      section.name = "Section" + sectionNumber.to_s
      
      section.book = "2 Peter"
      section.chapter = sectionChapter

      section.start_verse = 1
      section.end_verse = [3,5,7,8,9]
      
      sectionNumber += 1
      sectionChapter += 1
    end
        
    # Step 4: add some question_categories to work with
    question_categories = %w[Interrogative Finish\ The\ Verse Quote Reference Multiple\ Answer Situation]
    question_categories.each do |question_category_name|
      qc = QuestionCategory.new
      qc.name = question_category_name
      qc.save!
    end

    # Step 5: Add the types
    question_types = ["Interrogative",
                      "Finish The Verse",
                      "Finish This",
                      "Finish These Two Verses",
                      "Finish This And The Next",
                      "Quote",
                      "Quote These Two Verses",
                      "Chapter Only Reference",
                      "Chapter Verse Reference",
                      "Chapter Reference Multiple Answer",
                      "Chapter Verse Reference Multiple Answer",
                      "Multiple Answer",
                      "Situation"]
    question_types.each do |question_type_name|
      question_type = QuestionType.new
      question_type.name = question_type_name
      firstWord = question_type_name.split(' ').first
      
      #Figure out the category
      if firstWord == "Interrogative"
        question_category = QuestionCategory.find(:first, :conditions => ['name = ?', "Interrogative"])
      elsif firstWord == "Finish"
        question_category = QuestionCategory.find(:first, :conditions => ['name = ?', "Finish The Verse"])
      elsif firstWord == "Quote"
        question_category = QuestionCategory.find(:first, :conditions => ['name = ?', "Quote"])
      elsif firstWord == "Chapter"
        question_category = QuestionCategory.find(:first, :conditions => ['name = ?', "Reference"])
      elsif firstWord == "Multiple"
        question_category = QuestionCategory.find(:first, :conditions => ['name = ?', "Multiple Answer"])
      elsif firstWord == "Situation"
        question_category = QuestionCategory.find(:first, :conditions => ['name = ?', "Situation"])
      else
        question_category = QuestionCategory.new
      end
      
      question_type.question_category_id = question_category.id
      question_type.save!
    end
    
    # Step 6: add some questions to work with
    vidur = User.find_by_username('vidur')
    david = User.find_by_username('david')
    profh = User.find_by_username('profh')
    dom = User.find_by_username('dominic')
    derin = User.find_by_username('derin')
    
    writers = [vidur, david, profh, dom, derin]
	
    #Interrogative Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Interrogative"]).id
	    question.question_type_id = QuestionType.first.id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Finish The Verse Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Finish The Verse"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Finish The Verse"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Finish This Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Finish The Verse"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Finish This"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Finish These Two Verses Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Finish The Verse"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Finish These Two Verses"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Finish This And The Next Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Finish The Verse"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Finish This And The Next"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Quote Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Quote"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Quote"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Quote These Two Verses Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Quote"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Quote These Two Verses"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Chapter Only Reference Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Reference"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Chapter Only Reference"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Chapter Verse Reference Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Reference"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Chapter Verse Reference"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Chapter Reference Multiple Answer Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Multiple Answer"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Chapter Reference Multiple Answer"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Chapter Verse Reference Multiple Answer Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Multiple Answer"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Chapter Verse Reference Multiple Answer"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Multiple Answer Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Multiple Answer"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Multiple Answer"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
	
	#Situation Questions
    15.times do |question|
	    question = Question.new
	    question.book = "Hebrews"
	    question.chapter = 1
	    question.verse = "1"
	    question.section_id = Section.first.id
	    question.text = "Who has He appointed heir of all things?"
	    question.answer = "His son"
	    question.created_on = Time.now
	    question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Situation"]).id
	    question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', "Situation"]).id
	    question.written_by = writers.sample.id
    
    	question.save!
	end
    
    writer = User.find(:first, :conditions => ['username = ?', 'writer'])
    
    # Another question
    question = Question.new
    question.book = "Hebrews"
    question.chapter = 1
    question.verse = "1"
    question.section_id = Section.first.id
    question.text = "In the past God spoke..."
    question.answer = "to our forefathers many times and in various ways."
    question.created_on = Time.now - 5.days
    question.question_type_id = QuestionType.first.id
    question.written_by = writer.id
    question.save!
    
        # Some questions with varied creation times for Ernest Hemmingway
        question = Question.new
        question.book = "Hebrews"
        question.chapter = 1
        question.verse = "1"
        question.section_id = Section.first.id
        question.text = "Who has He appointed heir of all things?"
        question.answer = "His son"
        question.created_on = Time.now - 24.hours
        question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Interrogative"]).id
        question.question_type_id = QuestionType.first.id
        question.written_by = writer.id
    
    question.save!
    
    #     question = Question.new
    #     question.book = "Hebrews"
    #     question.chapter = 1
    #     question.verse = "1"
    #     question.section_id = Section.first.id
    #     question.text = "Who has He appointed heir of all things?"
    #     question.answer = "His son"
    #     question.created_on = Time.now - 24.minutes
    #     question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Interrogative"]).id
    #     question.question_type_id = QuestionType.first.id
    #     question.written_by = writer.id
    # 
    # question.save!
    # 
    # question = Question.new
    #     question.book = "Hebrews"
    #     question.chapter = 1
    #     question.verse = "1"
    #     question.section_id = Section.first.id
    #     question.text = "Who has He appointed heir of all things?"
    #     question.answer = "His son"
    #     question.created_on = Time.now - 24.days
    #     question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Interrogative"]).id
    #     question.question_type_id = QuestionType.first.id
    #     question.written_by = writer.id
    # 
    # question.save!
    # 
    # question = Question.new
    #     question.book = "Hebrews"
    #     question.chapter = 1
    #     question.verse = "1"
    #     question.section_id = Section.first.id
    # 
    #     question.text = "Who has He appointed heir of all things?"
    #     question.answer = "His son"
    #     question.created_on = Time.now - (24.hours+2.minutes)
    # 
    #     question.question_category_id = QuestionCategory.find(:first, :conditions => ['name = ?', "Interrogative"]).id
    #     question.question_type_id = QuestionType.first.id
    #     question.written_by = writer.id
    # 
    # question.save!

  end
  
end