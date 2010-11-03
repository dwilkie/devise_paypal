Given /^I want to authenticate with paypal$/ do
  body = "TOKEN=HA%2dH3Y5NAC5XV9LS&TIMESTAMP=2010%2d10%2d04T13%3a11%3a55Z&CORRELATIONID=37ccb34856012&ACK=Success&VERSION=2%2e3&BUILD=1516003"
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => body
  )
end

Given /^I have a paypal account(?: with #{capture_fields})?$/ do |fields|
  body_template = "PAYERID=RK7XZT4AUY79C&TIMESTAMP=2010%2d10%2d07T10%3a08%3a44Z&CORRELATIONID=83dfe25684ced&ACK=Success&VERSION=2%2e3&BUILD=1545724&L_ACCESSPERMISSIONNAME0=MassPay&L_ACCESSPERMISSIONSTATUS0=Accepted"
  paypal_credentials = parse_fields(fields)
  parsed_paypal_credentials = {}
  paypal_credentials.each do |key, value|
    parsed_paypal_credentials[key.classify.upcase] = value
  end
  paypal_credentials = parsed_paypal_credentials
  paypal_response = Rack::Utils.parse_nested_query(body_template)
  paypal_response.merge!(paypal_credentials)
  response_body = Rack::Utils.build_nested_query(paypal_response)
  paypal_credentials = parse_fields(fields)
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => response_body
  )
end

Given /^I sign into paypal and grant the required permissions$/ do
  @token = "HA-H3Y5NAC5XV9LS"
end

Given /^I sign into paypal but do not grant the required permissions$/ do
  @token = "HA-H3Y5NAC5XV9LS"
  body = "TIMESTAMP=2010%2d10%2d08T11%3a35%3a41Z&CORRELATIONID=d41ee44136721&ACK=Failure&VERSION=2%2e3&BUILD=1545724&L_ERRORCODE0=11622&L_SHORTMESSAGE0=User%20Does%20Not%20Exist%2e&L_LONGMESSAGE0=User%20may%20not%20have%20logged%20in%20using%20this%20token%2e&L_SEVERITYCODE0=Error"
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => body
  )
end

Given /^I do not sign into paypal$/ do
  # this step is intentionally blank
end

When /^I am redirected back to the application from paypal$/ do
  When "I go to the paypal permissions callback page"
end

Then /^I should be redirected to sign in with paypal$/ do
  Then %{I should be at "#{Paypal.uri}"}
  Then %{I should have the following query string:}, table(%{
    | _cmd  | _access-permission-login |
    | token | HA-H3Y5NAC5XV9LS         |
  })
end

