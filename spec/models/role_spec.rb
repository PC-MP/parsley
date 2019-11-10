# frozen_string_literal: true

require 'rails_helper'

# == Schema Information
#
# Table name: roles
#
#  id           :integer          not null, primary key
#  group_id     :integer          not null
#  user_id      :integer          not null
#  role         :integer          default("1"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default("0")
#  deleted_at   :datetime
#
# Indexes
#
#  index_roles_on_group_id              (group_id)
#  index_roles_on_group_id_and_user_id  (group_id,user_id) UNIQUE
#  index_roles_on_user_id               (user_id)
#
RSpec.describe Role, type: :model do
  subject(:described_instance) { FactoryBot.build :role }

  describe 'db index' do
    it { is_expected.to have_db_index(:group_id) }
    it { is_expected.to have_db_index(%i[group_id user_id]).unique }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:group) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'attributes' do
    it { is_expected.to define_enum_for(:role).with_values(guest: 1, admin: 5, owner: 10) }
  end
end
