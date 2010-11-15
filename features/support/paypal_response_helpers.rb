module PaypalResponseHelpers
  def register_get_user_details_response
    body_template = "PAYERID=RK7XZT4AUY79C&TIMESTAMP=2010%2d10%2d07T10%3a08%3a44Z&CORRELATIONID=83dfe25684ced&ACK=Success&VERSION=2%2e3&BUILD=1545724"
    paypal_response = Rack::Utils.parse_nested_query(body_template)
    paypal_response.merge!(@paypal_user_details)
    response_body = Rack::Utils.build_nested_query(paypal_response)
    FakeWeb.register_uri(
      :post, Paypal.nvp_uri, :body => response_body
    )
  end
end

World(PaypalResponseHelpers)

