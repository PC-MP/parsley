# frozen_string_literal: true

require 'rails_helper'

# == Schema Information
#
# Table name: invitation_tickets
#
#  id           :integer          not null, primary key
#  library_id   :integer          not null
#  ticket_hash  :string(16)       not null
#  expired_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default("0")
#  deleted_at   :datetime
#
# Indexes
#
#  index_invitation_tickets_on_library_id   (library_id)
#  index_invitation_tickets_on_ticket_hash  (ticket_hash) UNIQUE
#
RSpec.describe InvitationTicket, type: :model do
  subject(:described_instance) { FactoryBot.build :invitation_ticket }

  describe 'db index' do
    it { is_expected.to have_db_index(:library_id) }
    it { is_expected.to have_db_index(:ticket_hash).unique }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:library) }
  end

  describe 'callbacks' do
    describe 'before_validation' do
      subject(:exec_valid) { described_instance.valid? }

      describe ':set_defaults, on: :create' do
        let(:described_instance) { FactoryBot.build :invitation_ticket, ticket_hash: nil }

        it { expect { exec_valid }.to change(described_instance, :ticket_hash).from(nil) }
      end
    end
  end

  describe 'validations' do
    # it { is_expected.to validate_presence_of(:ticket_hash) }
    it { is_expected.to validate_length_of(:ticket_hash).is_equal_to(16) }
  end

  describe 'private' do
    describe '#set_defaults' do
      subject { described_instance.send :set_defaults }

      it { is_expected.to match(/\A[a-zA-Z0-9]{16}\z/) }

      describe 'described_instance' do
        before { described_instance.send :set_defaults }

        describe '@ticket_hash' do
          subject { described_instance.ticket_hash }

          it { is_expected.to match(/\A[a-zA-Z0-9]{16}\z/) }
        end
      end
    end
  end
end
