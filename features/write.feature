#*********************************************************
#====	             Write Feature                     ===
#*********************************************************

Feature: Write a question
	In order to submit a question into the system for approval
	As a writer
	I want to write a question

	Background:
		Given setup
		Given a logged in writer

	######################################################
	### Create Scenarios ###
	######################################################

	Scenario: Create a question fails because required fields are unfilled
		Given I am on the write page
		Then I should see "Welcome, Ernest Hemingway"
		Then I should see "Add A New Question"
		When I press "Submit"
		Then I should see "Book can't be blank"
		And I should see "Verse can't be blank"
		And I should see "Text can't be blank"
		And I should see "Answer can't be blank"
		And I should see "Question type can't be blank"
		And I should see "Chapter is not a number"
		# And I should not see "Section Error: This verse is not included in the material covered in Bible quizzing"

	Scenario: Create a question fails because of invalid chapter/verse
		Given I am on the write page
		And I select "QT" from "question_question_type_id"
		When I fill in "question_text" with "Do you yawn in your sleep?"
		And I fill in "question_answer" with "Yes."
		And I select "Hebrews" from "question_book"
		And I fill in "question_chapter" with "1"
		And I fill in "question_verse" with "99999"
		And I select "3" from "question_keyword"
		And I press "Submit"
		Then I should see "Section Error: This verse is not included in the material covered in Bible quizzing"
		
	Scenario: Create a question fails because of invalid chapter/verse
		Given I am on the write page
		And I select "QT" from "question_question_type_id"
		When I fill in "question_text" with "Do you yawn in your sleep?"
		And I fill in "question_answer" with "Yes."
		And I select "Hebrews" from "question_book"
		And I fill in "question_chapter" with "1"
		And I fill in "question_verse" with "99999"
		And I select "2" from "question_keyword"
		And I press "Submit"
		And I should see "Section Error: This verse is not included in the material covered in Bible quizzing"
		
	Scenario: Create a new question is successful
		Given I am on the write page
		And I select "QT" from "question_question_type_id"
		And I fill in "question_text" with "If money doesn't grow on trees then why do banks have branches? "
		And I fill in "question_answer" with "Money is made of paper which comes from trees."
		And I select "Hebrews" from "question_book"
		And I fill in "question_chapter" with "1"
		And I fill in "question_verse" with "3"
		And I select "3" from "question_keyword"
		And I press "Submit"
		Then I should see "If money doesn't grow on trees then why do banks have branches?"
		
	######################################################
	### Read Scenarios ###
	######################################################
	Scenario: View a list of my questions
		Given I am on the write page
		And I should see "Type"
		And I should see "Question"
		And I should see "Reference"
		# new question
		And I should see "What is the meaning of life?"
		# pending questions
		And I should see "If pro and con are opposites, wouldn't the opposite of progress be congress?"
		And I should see "You're funny."
		And I should see "If a doctor suddenly had a heart attack while doing surgery, wou...(more)"
		And I should see "The patient."
		
	Scenario: List only my questions 
		Given another writer with questions
		When I go to the write page
		# Then show me the page
		Then I should see "What is the meaning of life?"	
		And I should not see "Do fish get thirsty?"
		# see ehemingway's questions, not jausten's questions

############################################################################################################

	# Scenario: View details of a question that is too long
	# 	Given an existing question with the following data:
	# 		| question_type_id  | "QT"         		  					 |
	# 		| book              | "1 Peter"               			   	 |
	# 		| text        	    | "If there were a thousand seagulls in an airplane while its flying, each weighing two pounds a piece, but they were all flying in the airplane, would the airplane weigh 2000 pounds more?" |
	# 		| answer      	    | "No, the airplane would explode."      |
	# 		| chapter			| 2										 |
	# 		| verse				| "2"									 |
	# 		| written_by		| "ehemingway"							 |
	# 		When I go to the write page
	# 		Then show me the page

	Scenario: Attempt to view a question written by another writer fails
		Given another writer with questions
		When I go to the other writer's question details page
		# Then show me the page
		
	######################################################
	### Update Scenarios ###
	###################################################### 
		
	Scenario: Update a question successfully within 24 hours of creation
		Given an editable question
		Given I am on the write page
		When I follow "This is the editable question?"
		Then I should be on the edit question page
		And I should see "Edit Question"
		When I select "QT" from "question_question_type_id"
		And I fill in "question_text" with "This is a new question?"
		And I fill in "question_answer" with "Hopefully it shows up."
		And I select "1 Peter" from "question_book"
		And I fill in "question_chapter" with "1"
		And I fill in "question_verse" with "2"
		And I choose "question_keyword_3"
		And I press "Submit"
		# Then show me the page
		# Then I should see "Successfully updated question."
		Then I should see "This is a new question?"
		And I should not see "What is the meaning of life?"
			
	Scenario: Update a question within 24 hours of creation successfully without making any changes
		Given an editable question
		Given I am on the editable question details page
		Then I should see "This is the editable question?"
		When I follow "Edit"
		And I press "Update Question"
		Then I should see "Successfully updated question."
		And I should see "This is the question after edit?"

	Scenario: Update a question fails because of invalid chapter/verse
			Given an editable question
			Given I am on the write page
			When I follow "This is the editable question?"
			Then I should be on the edit question page
			Then I should see "Edit Question"
			And I select "QT" from "question_question_type_id"
			And I fill in "question_text" with "This is a new question?"
			And I fill in "question_answer" with "Hopefully it shows up."
			And I select "Hebrews" from "question_book"
			And I fill in "question_chapter" with "1"
			And I fill in "question_verse" with "22"
			And I choose "question_keyword_3"
			And I press "Submit"	
			Then I should see "Section Error: This verse is not included in the material covered in Bible quizzing"

	Scenario: Update an editable question fails due to invalid input
		Given an editable question
		Given I am on the editable question details page
		Then I should see "This is the editable question?"
		When I follow "Edit"
		Then I should see "Edit Question"
		And I fill in "question_text" with ""
		And I fill in "question_answer" with ""
		And I press "Submit"
		Then I should see "Text can't be blank"
		And I should see "Answer can't be blank"
	 		
	Scenario: Edit a question after 24 hours of creation fails
		Given I am on the pending approval question details page
		When I follow "Edit"
		Then I should see "You are not authorized to access this page"
	
	Scenario: Attempt to edit a question written by another writer fails
		Given another writer with questions
		When I go to edit the other writer's question
		# Then show me the page
		Then I should see "You are not authorized to access this page"			
				
	# ######################################################
	# ### Delete Scenarios ###
	# ######################################################		
		# # Scenario: a writer can delete a question within 24 hours of creation

		# # Scenario: a writer cannot delete a question after 24 hours of creation

