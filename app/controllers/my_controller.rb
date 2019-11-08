# frozen_string_literal: true

# MyController
class MyController < ApplicationController
  include Pundit
  include DeviseUserLoginHelper

  before_action :authenticate_user!
  def top; end
end
