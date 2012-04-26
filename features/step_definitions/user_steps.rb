Given /^setup$/ do
   # roles
   @approver = Factory.create(:role, :name => "Approver")
   @writer = Factory.create(:role, :name => "Writer")
   @coach = Factory.create(:role, :name => "Coach")
   @admin = Factory.create(:role, :name => "Admin")

   # A user 
   @ehemingway = Factory.create(:user, :username => "ehemingway", :first_name => "Ernest", :last_name => "Hemingway", :email => "ehemingway@example.com")
   @jausten = Factory.create(:user, :username => "jausten", :first_name => "Jane", :last_name => "Austen", :email => "jausten@example.com")
   @atrebek = Factory.create(:user, :username => "atrebek", :first_name => "Alex", :last_name => "Trebek", :email => "atrebek@example.com")
   @god = Factory.create(:user, :username => "ggod", :first_name => "God", :last_name => "God", :email => "god@heaven.com")
   
   #user roles
   @writer1role = Factory.create(:user_role, :role => @writer, :user => @ehemingway)
   @writer2role = Factory.create(:user_role, :role => @writer, :user => @jausten)
   @approverrole = Factory.create(:user_role, :role => @approver, :user => @atrebek)
   @adminrole = Factory.create(:user_role, :role => @admin, :user => @god)
 
   #sections
   @peter = Factory.create(:section, :name => "section1", :book => "1 Peter", :chapter => 2, :start_verse => 1, :end_verse => 3)

   # question_categories
   # {'Interrogavite' => 'INT', 'Finish The Verse' => 'FTV', 'Quote' => 'QT', 'Reference' => 'REF', 'Multiple Answer' => 'MA', 'Situation' => 'SIT'}   
   @qc_int = Factory.create(:question_category, :name => "Interrogative")
   @qc_ftv = Factory.create(:question_category, :name => "Finish The Verse")
   @qc_qt = Factory.create(:question_category, :name => "Quote")
   @qc_ref = Factory.create(:question_category, :name => "Reference")
   @qc_ma = Factory.create(:question_category, :name => "Multiple Answer")
   @qc_sit = Factory.create(:question_category, :name => "Situation")
 	 
   # question_types
   # {'Interrogative' => 'INT', 'Finish The Verse' => 'FTV', 'Finish This' => 'FT', 'Finish These Two Verses' => 'FT2V', 'Finish This And The Next' => 'FTN', 'Quote' => 'QT', 'Quote These Two Verses' => 'Q2V', 'Chapter Only Reference' => 'CR', 'Chapter Verse Reference' => 'CVR', 'Chapter Reference Multiple Answer' => 'CRMA', 'Chapter Verse Reference Multiple Answer' => 'CVRMA', 'Multiple Answer' => 'MA', 'Situation' => 'SIT'}
   @qt_int = Factory.create(:question_type, :name => "Interrogative", :question_category => @qc_int)
   @qt_ftv = Factory.create(:question_type, :name => "Finish The Verse", :question_category => @qc_ftv)
   @qt_ft = Factory.create(:question_type, :name => "Finish This", :question_category => @qc_ftv)
   @qt_ft2v = Factory.create(:question_type, :name => "Finish These Two Verses", :question_category => @qc_ftv)
   @qt_ftn = Factory.create(:question_type, :name => "Finish This And The Next", :question_category => @qc_ftv)
   @qt_qt = Factory.create(:question_type, :name => "Quote", :question_category => @qc_qt)
   @qt_q2v = Factory.create(:question_type, :name => "Quote These Two Verses", :question_category => @qc_qt)
   @qt_cr = Factory.create(:question_type, :name => "Chapter Only Reference", :question_category => @qc_ref)
   @qt_cvr = Factory.create(:question_type, :name => "Chapter Verse Reference", :question_category => @qc_ref)
   @qt_crma = Factory.create(:question_type, :name => "Chapter Reference Multiple Answer", :question_category => @qc_ref)
   @qt_cvrma = Factory.create(:question_type, :name => "Chapter Verse Reference Multiple Answer", :question_category => @qc_ref)
   @qt_ma = Factory.create(:question_type, :name => "Multiple Answer", :question_category => @qc_ma)
   @qt_sit = Factory.create(:question_type, :name => "Situation", :question_category => @qc_sit)
   
 # New Question (not approvable yet)

      @editable = Factory.create(:question, :written_by => @ehemingway, :text => "What is the meaning of life?", :answer => "42.", :keyword => 2, :created_on => 3.days.ago )    

    # Pending Approval (no longer editable)
      @pending1 = Factory.create(:question, :written_by => @ehemingway, :text => "If a doctor suddenly had a heart attack while doing surgery, would the other doctors work on the doctor or the patient?", :answer => "The patient.", :created_on => 3.days.ago) 
      @pending2 = Factory.create(:question, :written_by => @ehemingway, :text => "If pro and con are opposites, wouldn't the opposite of progress be congress?", :answer => "You're funny.", :created_on => 25.hours.ago)  
 
    # Approved
    # -- for Church
      @church = Factory.create(:question, :written_by => @ehemingway, :text => "What is Satan's last name?", :answer => "Satan.", :created_on => 3.days.ago, :approved_by => @atrebek, :approval_level => 1) 
    # -- for District
      @district = Factory.create(:question, :written_by => @ehemingway, :text => "How much wood could a woodchuck chuck if a woodchuck could chuck wood?", :answer => "A woodchuck could chuck as much wood as a woodchuck could chuck if a woodchuck could chuck wood.", :created_on => 2.years.ago, :approved_by => @atrebek, :approval_level => 2) 
    # -- or District & International
      @dist_int = Factory.create(:question, :written_by => @ehemingway, :text => "Since bread is square, then why is sandwich meat round?", :answer => "Because people are silly.", :keyword => 2, :created_on => 27.hours.ago, :approved_by => @atrebek, :approval_level => 3)
 
    # -- for International
      @international = Factory.create(:question, :written_by => @ehemingway, :text => "Why doesn't McDonald's sell hotdogs??", :answer => "Because they sell hamburgers.", :created_on => 3.years.ago, :approved_by => @atrebek, :approval_level => 4) 
    # -- passed to another approver
      @another_approver = Factory.create(:question, :written_by => @ehemingway, :text => "Why is vanilla ice cream white when vanilla extract is brown?", :answer => "I am Sorry, I don't know.", :created_on => 5.days.ago, :approved_by => @atrebek, :approval_level => 5)
 
    # Rejected - Questions created over 24 hours ago and rejected
      @rejected = Factory.create(:question, :written_by => @ehemingway, :text => "If milk goes bad if not refrigerated, does it go bad if the cow is not refrigerated?", :answer => "Maybe.", :created_on => 3.months.ago, :approved_by => @atrebek, :approval_level => -1)
 

end

Given /^a valid user$/ do 
  # A valid user with no role 
  @vuser = Factory.create(:user)
end


Given /^a logged in user$/ do
  visit login_url
  fill_in "login", :with => "vuser"
  fill_in "password", :with => "secret"
  find("#sign-in").click
end
