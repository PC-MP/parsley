# frozen_string_literal: true

# Users::OmniauthCallbacksController
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # GET|POST /users/auth/slack/callback(.:format)
  def slack
    auth_env = request.env['omniauth.auth']
    pp auth_env
    user = User.create_with(
                 display_name: auth_env['info']['name'],
                 icon_url:     auth_env['info']['image'],
                 username:     auth_env['info']['nickname'],
                 email:        auth_env['info']['email'],
               ).find_or_create_by!(slack_uid: auth_env['uid'])
    sign_in_and_redirect user, event: :authentication
  end

  def after_omniauth_failure_path_for(scope)
    root_path
  end
end
