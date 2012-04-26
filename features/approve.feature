 #*********************************************************
 #====	           Approve Feature                     ===
 #*********************************************************
 
 Feature: Approve a question
 	In order to submit questions for use in the system
 	As an approver
 	I am able to assign an approval level to a question
 	As well as modify questions
 
 	Background:
 		Given setup
 		Given I am on the home page
		Given a logged in approver
 
 
 	######################################################
 	### Create Scenarios ###
 	######################################################
 	Scenario: Can not add a question
		And I go to the writer page
 		Then I should see "You are not authorized to access this page."
 
 	######################################################
 	### Read Scenarios ###
 	######################################################
 	Scenario: View pending questions
 		And I go to the home page
 		And I go to the approver page	
 	    Then I should see "Pending Questions"
 		And I should see "Question"
 		And I should see "Reference"
 		And I should see "Type"
 		
 	Scenario: View details of a pending question
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		Then I should see "42"
 		And I should see "Text"
 		And I should see "Approval level"
 
 	Scenario: Attempt to view a question written by myself fails
 		And I go to the approver page
 		Then I should see "Welcome, Alex Trebek"
 		And I go to not my approver page
 		Then I should not see "What is the answer?"
 		
 	Scenario: Attempt to view a question written less than 24 hours ago fails
 		And I go to the approver page
 		Then I should see "Welcome, Alex Trebek"
 		And I go to an early question
 		Then I should not see "Who is he who is called I am?"
 
 
 	######################################################
 	#### Update Scenarios ###
 	######################################################
 
 	Scenario: Approve a pending question
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		And I should see "Edit Question"
 		And I should see "Answer"
 		And I should see "42."
 		And I choose "question_approval_level_1"
 		And I press "Submit"
 		Then I should see "Successfully updated question"
 
 	Scenario: Approve for international level
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		And I should see "Edit Question"
 		And I choose "question_approval_level_4"
 		And I press "Submit"
 		Then I should see "Successfully updated question"
 
 	Scenario: Approve for district level
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		And I should see "Edit Question"
 		And I choose "question_approval_level_3"
 		And I press "Submit"
 		Then I should see "Successfully updated question"
 
 	Scenario: Reject a pending question
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		And I should see "Edit Question"
 		And I should see "Answer"
 		And I choose "question_approval_level_-1"
 		And I press "Submit"
 		Then I should see "Successfully updated question"
 
 	Scenario: Edit a question before approval
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		And I fill in "question_text" with "Who are you?"
 		And I press "Submit"
 		Then I should see "Successfully updated question"
 		And I should see "Who are you?"
 	
 	Scenario: Edit entire question before approval
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		And I select "FTV" from "question_question_type_id"
 		And I select "1 Peter" from "question_book"
 		And I fill in "question_chapter" with "2"
 		And I fill in "question_verse" with "2"
 		And I fill in "question_text" with "What is the question?"
 		And I fill in "question_answer" with "What is the answer?"
 		And I choose "question_keyword_3"
 		And I choose "question_approval_level_5"
 		And I fill in "question_approval_reason" with "LOLZ"
 		And I press "Submit"
 		And show me the page
 		Then I should see "Successfully updated question"
 
 	Scenario: Update with no changes
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		And I press "Submit"
 		Then I should see "Successfully updated question"
 
 	Scenario: Pass to another approver
 		And I go to the approver page
 		And I follow "Edit/Approve"
 		Then I should see "What is the meaning of life?"
 		And I should see "Edit Question"
 		And I choose "question_approval_level_5"
 		And I press "Submit"
 		Then I should see "Successfully updated question"
 
 
 	######################################################
 	### Delete Scenarios ###
 	######################################################
 	# Scenario: an approver can delete a question before approval
 
 
