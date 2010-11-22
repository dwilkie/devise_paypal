Given /^I sign into paypal through paypal permissions authable$/ do
  # this step is intentionally blank
end

Given /^I grant the required permissions$/ do
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => get_user_details_response(@paypal_user_details)
  )
end

Given /^I do not grant the required permissions$/ do
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => get_user_details_response(nil)
  )
end

When /^I am redirected back to the application from paypal after a permissions request$/ do
  When "I go to the paypal permissions callback page"
end

Then /^I should be requested to grant the required permissions$/ do
  Then %{I should have the following query string:}, table(%{
    | cmd  | _access-permission-login  |
    | token | HA-DJW3X5Y99KRR4         |
  })
end

