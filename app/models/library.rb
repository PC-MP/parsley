# frozen_string_literal: true

# Library
#
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
class Library < ApplicationRecord

  ### associations

  belongs_to :group
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  has_many :invitations, dependent: :destroy
  has_many :book_stocks, dependent: :destroy

  ### attributes

  ### callbacks

  ### validations

  validates :name,
            presence: true,
            length:   { in: 2..40 }

  ### mix-in

  acts_as_paranoid

  ### scope

  ### methods

end
