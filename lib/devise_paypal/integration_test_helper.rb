module DevisePaypal
  module IntegrationTestHelper
    def get_user_details_response(paypal_user_details, options = {})
      if options[:unauthorized] || paypal_user_details.nil?
        "TIMESTAMP=2010%2d10%2d08T11%3a35%3a41Z&CORRELATIONID=d41ee44136721&ACK=Failure&VERSION=2%2e3&BUILD=1545724&L_ERRORCODE0=11622&L_SHORTMESSAGE0=User%20Does%20Not%20Exist%2e&L_LONGMESSAGE0=User%20may%20not%20have%20logged%20in%20using%20this%20token%2e&L_SEVERITYCODE0=Error"
      else
        raise(
          ArgumentError,
          "You must specify a hash of paypal user details"
        ) unless paypal_user_details || !paypal_user_details.is_a?(Hash)
        body_template = "PAYERID=RK7XZT4AUY79C&TIMESTAMP=2010%2d10%2d07T10%3a08%3a44Z&CORRELATIONID=83dfe25684ced&ACK=Success&VERSION=2%2e3&BUILD=1545724"
        parsed_paypal_user_details = {}
        paypal_user_details.each do |key, value|
         parsed_paypal_user_details[key.classify.upcase] = value
        end
        paypal_user_details = parsed_paypal_user_details
        paypal_response = Rack::Utils.parse_nested_query(body_template)
        paypal_response.merge!(paypal_user_details)
        Rack::Utils.build_nested_query(paypal_response)
      end
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

