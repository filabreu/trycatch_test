RSpec.configure do |config|
  config.include AuthRequestHelper, :type => :request
  config.include AuthHelper, :type => :controller
end
