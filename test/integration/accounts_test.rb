require 'test_helper'

class AccountsTest < ActionController::IntegrationTest
  context "GET /accounts/user-login/present" do
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

  context "POST /accounts" do
    context "with valid parameters" do
      setup do
        @valid_parameters = {
          :login => 'jdoe',
          :password => 'password'
        }
      end
      
      should "return a Created status code" do
        post '/accounts.xml', :user => @valid_parameters
        assert_response :created
      end
      
      should "save a new User account" do
        assert_difference('User.count') do
          post '/accounts.xml', :user => @valid_parameters
        end
      end

      should "return a new user response in xml" do
        post '/accounts.xml', :user => @valid_parameters

        assert_select('user') do
          assert_select('firstname', 'jdoe')
          assert_select('lastname', 'jdoe')
          assert_select('login', 'jdoe')
          assert_select('mail', 'no-email-jdoe@example.com')
          assert_select('hashed-password', '5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8')
        end
        
      end
    end

    context "with invalid parameters" do
      setup do
        @invalid_parameters = {}
      end
      
      should "return an Unprocessable Entity status code" do
        post '/accounts.xml', :user => @invalid_parameters
        assert_response :unprocessable_entity
      end
      
      should "not save any User accounts" do
        assert_no_difference('User.count') do
          post '/accounts.xml', :user => @invalid_parameters
        end
      end

      should "return the errors in xml" do
        post '/accounts.xml', :user => @invalid_parameters

        assert_select('user', :count => 0)
        assert_select('errors') do
          assert_select('error', :text => "Login can't be blank")
          assert_select('error', :text => "Login is too long (maximum is 30 characters)")
          assert_select('error', :text => "Firstname can't be blank")
          assert_select('error', :text => "Firstname is too long (maximum is 30 characters)")
          assert_select('error', :text => "Lastname can't be blank")
          assert_select('error', :text => "Mail can't be blank")
          assert_select('error', :text => "Mail is too long (maximum is 60 characters)")
        end
        
      end
    end

  end
end
