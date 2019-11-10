# frozen_string_literal: true

require 'rails_helper'

# == Schema Information
#
# Table name: groups
#
#  id           :integer          not null, primary key
#  name         :string(40)       not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default("0")
#  deleted_at   :datetime
#
RSpec.describe Group, type: :model do
  subject(:described_instance) { FactoryBot.build :group }

  describe 'associations' do
    it { is_expected.to have_many(:users).dependent(:destroy) }
    it { is_expected.to have_many(:libraries).dependent(:destroy) }
    it { is_expected.to have_many(:roles).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(40) }
  end
end
