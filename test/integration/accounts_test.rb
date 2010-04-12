require 'test_helper'

class AccountsTest < ActionController::IntegrationTest
  context "/accounts/user-login/present" do
    context "with a present user" do
      setup do
        @user = User.generate!
      end
      
      should "return a 200 status code" do
        get "/accounts/#{@user.login}/present.xml"
        assert_response :ok
      end
      
      should "return an empty body" do
        get "/accounts/#{@user.login}/present.xml"
        assert response.body.blank?
      end

    end
    
    context "with a missing user" do

      should "return a No Content status code" do
        get '/accounts/not-here/present.xml'
        assert_response :no_content
      end
      
      should "return an empty body" do
        get '/accounts/not-here/present.xml'
        assert response.body.blank?
      end
    end
    
  end
end
