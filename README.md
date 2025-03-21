# name: discourse-skip-email-verification
# about: Skip email verification during user registration (Universal - Direct Signup and Invitations)
# version: 2.0
# authors: thenogodcom
# url: https://github.com/thenogodcom/discourse-auth-no-email-verification

cd /var/discourse

nano containers/app.yml

- git	clone https://github.com/thenogodcom/discourse-auth-no-email-verification.git

- cd /var/discourse

./launcher rebuild app
