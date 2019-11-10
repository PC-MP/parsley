# frozen_string_literal: true

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
FactoryBot.define do
  factory :role do
    association :group
    association :user

    trait :guest do
      role { :guest }
    end

    trait :admin do
      role { :admin }
    end

    trait :owner do
      role { :owner }
    end

    factory :guest_role, traits: %i[guest]
    factory :admin_role, traits: %i[admin]
    factory :owner_role, traits: %i[owner]
  end
end
