@devise_paypal
Feature: Authenticate using Paypal Authable
  In order to signup or login using by logging into paypal
  As a user
  I want to be able to authenticate using the Paypal authable api

  Scenario: I authenticate with Paypal authable
    When I go to the authenticate with paypal authable page

    Then I should be redirected to sign in with paypal
    And I should be requested to grant access to my name and email address

  Scenario: I sign into paypal
    Given I have a paypal account with email: "mara@example.com"
    And I sign into paypal through paypal authable

    When I am redirected back to the application from paypal after an authentication request

    Then a user should exist with email: "mara@example.com"
    And I should be on the home page
    And I should see "Successfully authorized from Paypal account."

  Scenario: I do not sign into paypal
    Given I have a paypal account with email: "mara@example.com"
    But I do not sign into paypal

    When I am redirected back to the application from paypal after an authentication request

    Then a user should not exist with email: "mara@example.com"

