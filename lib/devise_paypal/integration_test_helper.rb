module DevisePaypal
  module IntegrationTestHelper
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

