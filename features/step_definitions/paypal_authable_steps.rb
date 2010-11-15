Given /^I sign into paypal through paypal authable$/ do
  register_get_user_details_response
end

Then /^I should be requested to grant access to my name and email address$/ do
  Then %{I should have the following query string:}, table(%{
    | cmd  | _account-authenticate-login  |
    | token | HA-DJW3X5Y99KRR4            |
  })
end

