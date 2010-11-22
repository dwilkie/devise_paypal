Given /^I have a paypal account(?: with #{capture_fields})?$/ do |fields|
  @paypal_user_details = parse_fields(fields)
end

Given /^I do not sign into paypal$/ do
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => get_user_details_response(nil)
  )
end

Then /^I should be redirected to sign in with paypal$/ do
  assert_equal_to_paypal_url(current_url, Paypal.uri)
end

