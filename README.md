# Secure File Transfer

Alows you to securely transfer files between users. Supports 2-factor
authentication and verification of X-509 certificates.

To run:
    bundle install
    rake db:create
    rake db:migrate
    #export environment variables
    #export AES_KEY=...
    #export IV_KEY=...
    #export BASE_KEY=...
    rails s -p 3000
