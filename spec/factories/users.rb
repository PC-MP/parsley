# frozen_string_literal: true

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
FactoryBot.define do
  factory :user do
    username     { generate :username }
    email        { username + '@' + generate(:domain) }
    slack_uid    { 'U' + SecureRandom.alphanumeric(8).upcase }
    display_name { generate :display_name }
    icon_url     { Faker::Avatar.image(slug: username, size: '48x48') }
    association  :group
  end
end
