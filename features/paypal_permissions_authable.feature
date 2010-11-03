Feature: Authenticate using Paypal Permissions Authable
  In order to avoid filling out forms when signing up or logging in
  As a user
  I want to be able to authenticate using paypal's permissions api

  Scenario: I authenticate with paypal permissions authable
    Given I want to authenticate with paypal

    When I go to the authenticate with paypal permissions page

    Then I should be redirected to sign in with paypal

  @current
  Scenario: I grant the required permissions
    Given I have a paypal account with email: "mara@example.com"
    And I sign into paypal and grant the required permissions

    When I am redirected back to the application from paypal

    Then a user should exist with email: "mara@example.com"
    And I should be on the home page
    And I should see "Signed in successfully from Paypal account."

  Scenario: I do not grant the required permissions
    Given I have a paypal account with email: "mara@example.com"
    And I sign into paypal but do not grant the required permissions

    When I am redirected back to the application from paypal

    Then a user should not exist with email: "mara@example.com"
    And I should be on the home page
    And I should see "Unable to"

  Scenario: I do not sign into paypal
    Given I do not sign into paypal

    When I am redirected back to the application from paypal

    Then a user should not exist with email: "mara@example.com"

