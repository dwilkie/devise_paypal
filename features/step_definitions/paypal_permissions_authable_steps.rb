Given /^I sign into paypal through paypal permissions authable$/ do
  # this step is intentionally blank
end

Given /^I grant the required permissions$/ do
  register_get_user_details_response
end

Given /^I do not grant the required permissions$/ do
  body = "TIMESTAMP=2010%2d10%2d08T11%3a35%3a41Z&CORRELATIONID=d41ee44136721&ACK=Failure&VERSION=2%2e3&BUILD=1545724&L_ERRORCODE0=11622&L_SHORTMESSAGE0=User%20Does%20Not%20Exist%2e&L_LONGMESSAGE0=User%20may%20not%20have%20logged%20in%20using%20this%20token%2e&L_SEVERITYCODE0=Error"
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => body
  )
end

Then /^I should be requested to grant the required permissions$/ do
  Then %{I should have the following query string:}, table(%{
    | cmd  | _access-permission-login  |
    | token | HA-DJW3X5Y99KRR4         |
  })
end

