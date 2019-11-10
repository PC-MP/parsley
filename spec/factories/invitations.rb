# frozen_string_literal: true

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
FactoryBot.define do
  factory :invitation do
    association :user
    association :invited_by, factory: :user
    library     { create(:library, group: invited_by.group) }

    trait :expired do
      expired_at { Time.zone.now.yesterday }
    end

    trait :guest do
      role { :guest }
    end

    trait :librarian do
      role { :librarian }
    end

    factory :guest_invitation,     traits: %i[guest]
    factory :librarian_invitation, traits: %i[librarian]
    factory :expired_invitation,   traits: %i[expired]
  end
end
