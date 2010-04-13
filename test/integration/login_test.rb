require 'test_helper'

class LoginTest < ActionController::IntegrationTest
  context "POST /login" do
    setup do
      @user = User.generate!(:login => 'a-user',
                             :password => 'test',
                             :password_confirmation => 'test')
    end

    context "with a valid user login and password" do
      should "return an OK status code" do
        post "/login.xml", :login => 'a-user', :password => 'test'
        assert_response :ok
      end

      should "return a user response in xml" do
        post "/login.xml", :login => 'a-user', :password => 'test'

        assert_select('user') do
          assert_select('login', 'a-user')
          assert_select('hashed-password')
        end
      end
    end

    context "with a valid user but invalid password" do
      should "return an Unauthorized status code" do
        post "/login.xml", :login => 'a-user', :password => 'wrong'
        assert_response :unauthorized
      end

      should "return an empty body" do
        post "/login.xml", :login => 'a-user', :password => 'wrong'
        assert response.body.blank?
      end
    end

    context "with an invalid user" do
      should "return an Unauthorized status code" do
        post "/login.xml", :login => 'missing', :password => 'wrong'
        assert_response :unauthorized
      end

      should "return an empty body" do
        post "/login.xml", :login => 'missing', :password => 'wrong'
        assert response.body.blank?
      end
    end
    
  end
end
