# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyController, type: :controller do

  describe 'GET #top' do
    it 'returns http success' do
      pending
      get :top
      expect(response).to have_http_status(:success)
    end
  end

end
