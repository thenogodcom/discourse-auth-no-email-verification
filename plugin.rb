# name: discourse-auth-no-email-verification
# about: Skip email verification during user registration (Universal - Direct Signup and Invitations)
# version: 2.0
# authors: thenogodcom
# url: https://github.com/thenogodcom/discourse-auth-no-email-verification

enabled_site_setting :auth_no_email_enabled

after_initialize do
  next unless SiteSetting.auth_no_email_enabled

  on(:user_created) do |user|
    user.active = true
    user.approved = true unless SiteSetting.must_approve_users?
    user.save!

    if user.staged
      EmailToken.where(user_id: user.id).update_all(confirmed: true)
    else
      token = EmailToken.find_by(email: user.email)
      if token
         token.confirmed = true
         token.save!
      end
    end
  end
end

register_asset "config/settings.yml"
