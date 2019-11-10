# frozen_string_literal: true

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
FactoryBot.define do
  factory :library do
    association :group
    owner       { create :user, group: group }
    name        { generate :library_name }
  end
end
