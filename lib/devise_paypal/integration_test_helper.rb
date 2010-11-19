module DevisePaypal
  module IntegrationTestHelper
    def get_user_details_response(paypal_user_details)
      parsed_paypal_user_details = {}
      paypal_user_details.each do |key, value|
        parsed_paypal_user_details[key.classify.upcase] = value
      end
      paypal_user_details = parsed_paypal_user_details
      body_template = "PAYERID=RK7XZT4AUY79C&TIMESTAMP=2010%2d10%2d07T10%3a08%3a44Z&CORRELATIONID=83dfe25684ced&ACK=Success&VERSION=2%2e3&BUILD=1545724"
      paypal_response = Rack::Utils.parse_nested_query(body_template)
      paypal_response.merge!(paypal_user_details)
      response_body = Rack::Utils.build_nested_query(paypal_response)
    end

    def assert_equal_to_paypal_url(url, paypal_url)
      uri = URI.parse(url)
      uri.query = nil
      uri.path = "" if uri.path == "/"
      uri = uri.to_s
      if uri.respond_to? :should
        uri.should == paypal_url
      else
        assert_equal uri, paypal_url
      end
    end
  end
end

