@devise_paypal
Feature: Authenticate using Paypal Permissions Authable
  In order to signup or login using Paypal and grant requested permissions
  As a user
  I want to be able to authenticate using the Paypal permissions api

  Scenario: I authenticate with Paypal permissions authable
    When I go to the authenticate with paypal permissions page

    Then I should be redirected to sign in with paypal
    And I should be requested to grant the required permissions

  Scenario: I grant the required permissions
    Given I have a paypal account with email: "mara@example.com"
    And I sign into paypal through paypal permissions authable
    And I grant the required permissions

    When I am redirected back to the application from paypal after a permissions request

    Then a user should exist with email: "mara@example.com"
    And I should be on the home page
    And I should see "Successfully authorized from Paypal account."

  Scenario: I do not grant the required permissions
    Given I have a paypal account with email: "mara@example.com"
    And I sign into paypal through paypal permissions authable
    But I do not grant the required permissions

    When I am redirected back to the application from paypal after a permissions request

    Then a user should not exist with email: "mara@example.com"
    And I should see "Unable to authorize you from Paypal account."

  Scenario: I do not sign into paypal
    Given I have a paypal account with email: "mara@example.com"
    But I do not sign into paypal

    When I am redirected back to the application from paypal after a permissions request

    Then a user should not exist with email: "mara@example.com"
    And I should see "Unable to authorize you from Paypal account."

