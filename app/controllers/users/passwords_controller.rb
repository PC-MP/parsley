# frozen_string_literal: true

# Users::PasswordsController
class Users::PasswordsController < Devise::PasswordsController
  include DeviseUserLoginHelper
end
