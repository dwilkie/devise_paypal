Given /^I sign into paypal through paypal authable$/ do
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => get_user_details_response(@paypal_user_details)
  )
end

When /^I am redirected back to the application from paypal after an authentication request$/ do
  When "I go to the paypal authable callback page"
end

Then /^I should be requested to grant access to my name and email address$/ do
  Then %{I should have the following query string:}, table(%{
    | cmd  | _account-authenticate-login  |
    | token | HA-DJW3X5Y99KRR4            |
  })
end

