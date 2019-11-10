# frozen_string_literal: true

require 'rails_helper'

# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  email              :string(255)
#  sign_in_count      :integer          default("0"), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string(255)
#  last_sign_in_ip    :string(255)
#  failed_attempts    :integer          default("0"), not null
#  unlock_token       :string(255)
#  locked_at          :datetime
#  slack_uid          :string(255)
#  username           :string(255)
#  display_name       :string(255)
#  icon_url           :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lock_version       :integer          default("0")
#  deleted_at         :datetime
#  group_id           :integer          not null
#
# Indexes
#
#  index_users_on_group_id      (group_id)
#  index_users_on_slack_uid     (slack_uid) UNIQUE
#  index_users_on_unlock_token  (unlock_token) UNIQUE
#
RSpec.describe User, type: :model do
  subject(:described_instance) { FactoryBot.build :user }

  describe 'db index' do
    it { is_expected.to have_db_index(:group_id) }
    it { is_expected.to have_db_index(:slack_uid).unique }
  end

  describe 'associations' do
    # it { is_expected.to belong_to(:group).required }
    it { is_expected.to have_many(:libraries).dependent(:destroy) }
    it { is_expected.to have_many(:roles).dependent(:destroy) }
  end

  describe 'callbacks' do
    describe 'before_validation' do
      subject(:exec_valid) { described_instance.valid? }

      describe ':create_group, on: :create' do
        let(:described_instance) { FactoryBot.build :user, group: nil }

        it { expect { exec_valid }.to change(described_instance, :group_id).from(nil) }
        it { expect { exec_valid }.to change(Group, :count).by(1) }
      end
    end

    describe 'after_create' do
      subject(:exec_save) { described_instance.save }

      describe ':create_owner_role' do
        it { expect { exec_save }.to change(Role, :count).by(1) }
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_length_of(:username).is_at_least(2).is_at_most(40) }
  end

  describe '#role_for' do
    subject { user.role_for library }

    context "with own group's library" do
      let(:group)   { FactoryBot.create :group }
      let(:user)    { FactoryBot.create :user,    group: group }
      let(:library) { FactoryBot.create :library, group: group, owner: user }

      it { is_expected.to eq :owner }
    end

    context "with permitted other group's library" do
      let(:group)       { FactoryBot.create :group }
      let(:other)       { FactoryBot.create :user,    group: group }
      let(:library)     { FactoryBot.create :library, group: group, owner: other }
      let(:user)        { FactoryBot.create :user }
      let(:group_role) { :admin }

      before { library.group.roles.create!(user: user, role: group_role) }

      it { is_expected.to eq group_role }
    end

    context "with invited other group's library" do
      let(:group)        { FactoryBot.create :group }
      let(:other)        { FactoryBot.create :user,    group: group }
      let(:library)      { FactoryBot.create :library, group: group, owner: other }
      let(:user)         { FactoryBot.create :user }
      let(:invited_role) { :librarian }

      before { library.invitations.create!(user: user, invited_by: other, role: invited_role) }

      it { is_expected.to eq invited_role }
    end
  end

  describe 'private' do
    describe '#create_group' do
      subject { described_instance.send :create_group }

      it { is_expected.to be_instance_of Group }
      its(:name) { is_expected.to eq described_instance.username }
    end
  end
end
