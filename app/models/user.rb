require "digest/sha1"

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessor :password_confirmation

  validates_presence_of :login
  validates_presence_of :firstname
  validates_presence_of :lastname
  validates_presence_of :mail

  validates_uniqueness_of :login
  validates_uniqueness_of :mail, :case_sensitive => false

  validates_length_of :login, :maximum => 30
  validates_length_of :firstname, :maximum => 30
  validates_length_of :mail, :maximum => 60

  validates_confirmation_of :password, :allow_nil => true

  before_save :store_password_hash

  def store_password_hash
    # update hashed_password if password was set
    self.hashed_password = User.hash_password(self.password) if self.password
  end

  # Try to login using the user's login or id and their plaintext password.
  def self.try_to_login(login_or_user_id, password)
    return nil if password.blank? || login_or_user_id.blank?

    user = User.find_by_login(login_or_user_id) # login
    user ||= User.find_by_id(login_or_user_id) # id

    if user
      if User.hash_password(password) == user.hashed_password
        user
      else
        nil
      end
    end
  end
  
  def self.new_from_limited_attributes(params)
    User.new do |user|
      user.login = params[:login]
      user.password = params[:password]
      user.password_confirmation = params[:password]
      user.firstname = params[:login]
      user.lastname = params[:login]
      user.mail = "no-email-#{params[:login]}@example.com"
    end
  end

  private

  # Return password digest
  def self.hash_password(clear_password)
    Digest::SHA1.hexdigest(clear_password || "")
  end

end
