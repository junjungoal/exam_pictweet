module AuthenticateHelper
  def login_user
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryGirl.create(:user)
    sign_in @user
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include AuthenticateHelper, type: :controller
end

