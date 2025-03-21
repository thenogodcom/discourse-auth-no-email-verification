# name: discourse-auth-no-email-verification
# about: Skip email verification during user registration (Universal - Direct Signup and Invitations)
# version: 2.0
# authors: thenogodcom
# url: https://github.com/thenogodcom/discourse-auth-no-email-verification

after_initialize do
  if SiteSetting.auth_no_email_enabled
    on(:user_created) do |user|
      user.update(active: true)
      user.update(approved: true) if !SiteSetting.must_approve_users?

      if user.staged
          EmailToken.where(user_id: user.id).update_all(confirmed: true)
      elsif token = EmailToken.find_by(email: user.email)
          token.update(confirmed: true)
      end
    end
  end
end

register_asset "config/settings.yml"
