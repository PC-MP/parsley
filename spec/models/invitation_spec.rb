# frozen_string_literal: true

require 'rails_helper'

# == Schema Information
#
# Table name: invitations
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  library_id    :integer          not null
#  invited_by_id :integer          not null
#  role          :integer          default("1"), not null
#  expired_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  lock_version  :integer          default("0")
#  deleted_at    :datetime
#
# Indexes
#
#  index_invitations_on_invited_by_id           (invited_by_id)
#  index_invitations_on_library_id              (library_id)
#  index_invitations_on_library_id_and_user_id  (library_id,user_id) UNIQUE
#  index_invitations_on_user_id                 (user_id)
#
RSpec.describe Invitation, type: :model do
  subject(:described_instance) { FactoryBot.build :invitation }

  describe 'db index' do
    it { is_expected.to have_db_index(:invited_by_id) }
    it { is_expected.to have_db_index(:library_id) }
    it { is_expected.to have_db_index(%i[library_id user_id]).unique }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:library) }
    it { is_expected.to belong_to(:invited_by).class_name('User') }
  end

  describe 'attributes' do
    it { is_expected.to define_enum_for(:role).with_values(guest: 1, librarian: 2) }
  end
end
