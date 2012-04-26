  #*********************************************************
  #====	           Authentication Feature                ===
  #*********************************************************

 Feature: Authentication
  In order to manage my questions
  As a user
  I want to create and access an account on the system

  Background:
    Given setup


  Scenario: Signup
    When I go to the home page
    And click on the link "Don't have an account?"
    And I fill in the following:
      | user_first_name            | Valid              |
      | user_last_name             | User               |
      | user_username              | vuser              |
      | user_email                 | vuser@example.com  |
      | user_password              | secret             |
      | user_password_confirmation | secret             |
    # And I click on the element "#sign-up-button"
    And I press "Sign Up"
    Then I should see "You are now logged in"
    # Can't pick a role?

  Scenario: Signup failure because required fields missing
    When I go to the home page
    And I fill in the following:
      | user_first_name             |                   |
      | user_last_name              |                   |
      | user_username               |                   |
      | user_email                  | vuser@example.com	|
      | user_password               | secret            |
      | user_password_confirmation  | secret            |
    Then I should see the element "#sign-up-button" is disabled
    # And I click the element "#sign-up-button"
    # Then I should see "First name can't be blank"
    # And I should see "Last name can't be blank"
    # And I should see "Username can't be blank"
    # And I should see "Password can't be blank"

  Scenario: Signup failure because of invalid entries
    When I go to the home page
    And I fill in the following:
      | user_first_name             | Valid             |
      | user_last_name              | User              |
      | user_username               | vuser             |
      | user_email                  | vuser@example,com	|
      | user_password               | secret            |
      | user_password_confirmation  | tacos             |
    # And I click on the element "#sign-up-button"
    And I press "Sign Up"
    And I should see "Email is invalid"
    Then I should see "Password doesn't match confirmation"
 
  Scenario: Signup failure because password is too short
    When I go to the home page
    When I fill in the following:
      | user_first_name             | Valid             |
      | user_last_name              | User              |
      | user_username               | vuser             |
      | user_email                  | vuser@example,com	|
      | user_password               | 1                 |
      | user_password_confirmation  | 1                 |
    # And I click on the element "#sign-up-button"
    And I press "Sign Up"
    And I should see "Email is invalid"
    Then I should see "Password is too short"

  Scenario: Login successful
    Given a valid user
    When I go to the home page
      And I fill in the following:
        | login       | vuser     |
        | password    | secret    |
    # And I click on the element "#sign-in"
    And I press "Sign in"
    And I should see "Logged in successfully"
    # Then I should see "Welcome, Valid User"

  Scenario: Login failed
    Given a valid user
    When I go to the home page
    And I fill in the following:
        | login	         | vuser	|
        | password       | tacos    |
    # And I click on the element "#sign-in"
    And I press "Sign in"
    Then I should see "Invalid login or password"

  Scenario: Logout
    Given a valid user
    Given a logged in user
    When I go to the home page
    And I click on the link "Log Out"
    Then I should see "You have been logged out"

