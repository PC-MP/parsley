# frozen_string_literal: true

# Users::SessionsController
class Users::SessionsController < Devise::SessionsController
  include DeviseUserLoginHelper
end
