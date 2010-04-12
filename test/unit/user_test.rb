require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should_validate_presence_of :login
  should_validate_presence_of :firstname
  should_validate_presence_of :lastname
  should_validate_presence_of :mail
  
  should_callback :store_password_hash, :before_save
end
