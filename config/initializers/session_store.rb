# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cits4242-project_session',
  :secret      => '2e809cf4d02b78c44e2f044e38759dad2ba048c16d422b1203e7f218b63a980dff73f24802e725b51e7f736fe54d57ea0868657b5b9acaaecaa25ffefe0e795e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
