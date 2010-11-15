Before do
  FakeWeb.clean_registry
end

Before("@paypal_authentication_request") do
  @token = "HA-DJW3X5Y99KRR4"
  body = "TOKEN=HA%2dDJW3X5Y99KRR4&TIMESTAMP=2010%2d10%2d07T10%3a06%3a31Z&CORRELATIONID=5c533a2b40c6a&ACK=Success&VERSION=2%2e3&BUILD=1545724"
  FakeWeb.register_uri(:post, Paypal.nvp_uri, :body => body)
end

