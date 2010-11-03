Then /^(?:|I )should be at "([^"]*)"$/ do |url|
  current_uri = URI.parse(current_url)
  current_uri.query = nil
  current_uri.path = "" if current_uri.path == "/"
  current_uri = current_uri.to_s
  if current_uri.respond_to? :should
    current_uri.should == url
  else
    assert_equal url, current_uri
  end
end

