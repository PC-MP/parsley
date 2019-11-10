# frozen_string_literal: true

# == Schema Information
#
# Table name: groups
#
#  id           :integer          not null, primary key
#  name         :string(40)       not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default("0")
#  deleted_at   :datetime
#
FactoryBot.define do
  factory :group do
    name { generate :group_name }
  end
end
