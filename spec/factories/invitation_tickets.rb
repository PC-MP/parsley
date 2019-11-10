# frozen_string_literal: true

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
FactoryBot.define do
  factory :invitation_ticket do
    association :library

    ticket_hash { SecureRandom.alphanumeric 16 }

    trait :expired do
      expired_at { Time.zone.now.yesterday }
    end

    factory :expired_invitation_ticket, traits: %i[expired]
  end
end
