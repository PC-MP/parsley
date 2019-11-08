# frozen_string_literal: true

# DeviseUserLoginHelper
module DeviseUserLoginHelper

  def resource
    instance_variable_get(:"@#{resource_name}")
  end

  def resource_name
    :user
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation)
    end
  end
end
