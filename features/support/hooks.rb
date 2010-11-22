Before do
  FakeWeb.clean_registry
end

Before("@devise_paypal") do
  paypal_response = setup_auth_flow_response
  @token = paypal_response[:token]
  FakeWeb.register_uri(
    :post, Paypal.nvp_uri, :body => paypal_response[:body]
  )
end

