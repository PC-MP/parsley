# frozen_string_literal: true

# Group
#
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
class Group < ApplicationRecord

  ### associations

  has_many :users,     dependent: :destroy
  has_many :libraries, dependent: :destroy
  has_many :roles,     dependent: :destroy

  ### attributes

  ### callbacks

  ### validations

  validates :name,
            presence: true,
            length:   { in: 2..40 }

  ### mix-in

  acts_as_paranoid

  ### methods

end
