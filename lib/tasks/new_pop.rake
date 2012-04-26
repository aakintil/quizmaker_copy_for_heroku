namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :new_pop => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    # Generates fake data
    require 'faker'
    require 'iconv' # you need this for the UTF-8 
    
    QT= {'INT' => 'Interrogative', 'FTV' => 'Finish The Verse', 'FT' => 'Finish This', 'FT2V' => 'Finish These Two Verses', 'FTN' => 'Finish This And The Next', 'QT' => 'Quote', 'Q2V' => 'Quote These Two Verses', 'CR' => 'Chapter Only Reference', 'CVR' => 'Chapter Verse Reference', 'CRMA' => 'Chapter Reference Multiple Answer', 'CVRMA' => 'Chapter Verse Reference Multiple Answer', 'MA' => 'Multiple Answer', 'SIT' => 'Situation'}

    # Step 1: clear any old data in the db
    [Question].each(&:delete_all)


    # Step 2: Make writers
    vidur = User.find_by_username('vidur')
    david = User.find_by_username('david')
    profh = User.find_by_username('profh')
    dom = User.find_by_username('dominic')
    derin = User.find_by_username('derin')
    
    writers = [vidur, david, profh, dom, derin]
    
    # Step 3: Parse file and create questions
    i = 0; 
    orig_file = File.open("testing.txt")
    orig_file.each_line do |line|
      random_rank = rand(3)+1
      i+=1
      ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
      transcoded = ic.iconv(line + ' ')[0..-2]
      abbreviation, books, questions, answers, ignore = transcoded.split(/\t/)
      abr = abbreviation.strip
      colon = books.index(":")
      chpt = colon - 1
      vrs = colon + 1
      
      
      question = Question.new
      question.book = books[0..colon-3].to_s
      question.chapter = books[chpt].chr.to_i
      question.verse = books[vrs].chr.to_s
      question.section_id = Section.first.id
      question.text = questions
      question.answer = answers
      question.position = i
      question.difficulty_ranking = random_rank
      question.created_on = Time.now
      qt = QuestionType.find(:first, :conditions => ['name = ?', QT[abr]])
      puts "Invalid question type: #{qt}, on line: #{i}" if (qt.nil?)
      question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', QT[abr]]).id
      question.question_category_id = question.question_type.question_category.id
      question.written_by =  writers.sample.id #if this doesn't work just use 1

      question.save!

    end
    puts "Number of Questions Generated: #{i}"
  end
end


# IN CASE IT EVER STOPS WORKING!! USE NESTED FOUR LOOP
# orig_file.each_line do |string|
#    i+=1
#    puts i
#    ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
#    valid = ic.iconv(string + ' ')[0..-2]
#    # puts "----Original----"
#    #        puts string.encoding.name
#    #        puts string.bytesize
#    #        puts string.valid_encoding?
#    #        
#    #        transcoded = string.encode("UTF-8")
#    #        
#    #        puts "----Transcoded----"
#    #        puts transcoded.encoding.name
#    #        puts transcoded.bytesize
#    #        puts transcoded.valid_encoding?
#    
#    puts string.inspect
#    
#    valid = valid.split(/\+/)
#    #valid.gsub!(/\+/, "\n")
#    puts valid.inspect
#    valid.each do |line|
#      puts line
#      abbreviation, books, questions, answers = line.split(/\t/)
#      abr = abbreviation.strip
#      puts abr
#      puts "#{QT[abr]}"
#      # qc = QuestionType.find(:first, :conditions => ['name = ?', QUESTION_TYPES[abr]])
#      #         puts qc.name
#      question = Question.new
#      question.book = books
#      question.chapter = 1
#      question.verse = "1"
#      question.section_id = Section.first.id
#      question.text = questions
#      question.answer = answers
#      question.created_on = Time.now
#      question.question_type_id = QuestionType.find(:first, :conditions => ['name = ?', QT[abr]]).id
#      question.question_category_id = question.question_type.question_category.id
#      question.written_by = 1
# 
#      question.save!
#    end
#  end