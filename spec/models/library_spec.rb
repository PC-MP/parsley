# frozen_string_literal: true

require 'rails_helper'

# == Schema Information
#
# Table name: libraries
#
#  id           :integer          not null, primary key
#  group_id     :integer          not null
#  user_id      :integer          not null
#  name         :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default("0")
#  deleted_at   :datetime
#
# Indexes
#
#  index_libraries_on_group_id  (group_id)
#  index_libraries_on_user_id   (user_id)
#
RSpec.describe Library, type: :model do
  subject(:described_instance) { FactoryBot.build :library }

  describe 'db index' do
    it { is_expected.to have_db_index(:group_id) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to belong_to(:owner).class_name('User').with_foreign_key('user_id') }
    it { is_expected.to have_many(:invitations).dependent(:destroy) }
    it { is_expected.to have_many(:book_stocks).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2).is_at_most(40) }
  end
end
