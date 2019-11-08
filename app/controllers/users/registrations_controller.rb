# frozen_string_literal: true

# Users::RegistrationsController
class Users::RegistrationsController < Devise::RegistrationsController
  include DeviseUserLoginHelper
  before_action :configure_permitted_parameters
end
