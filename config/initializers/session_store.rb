# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_redmine_sso_server_session',
  :secret      => 'c7d8ed390c41e4c0bb9fc1cc5f26b127b2523706ac5f9075f450441f01ed5b10d61351ad0e5f2e093fb8586686a9274aabb1423444e3c91c0f5b21ab2abf4f25'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
