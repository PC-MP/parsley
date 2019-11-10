# frozen_string_literal: true

# Role
#
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
class Role < ApplicationRecord

  ### associations

  belongs_to :group
  belongs_to :user

  ### attributes

  enum role: { guest: 1, admin: 5, owner: 10 }

  ### callbacks

  ### validations

  ### mix-in

  acts_as_paranoid

  ### methods

end
