# frozen_string_literal: true

# Invitation
#
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
class Invitation < ApplicationRecord
  include ExpiredScope

  ### associations

  belongs_to :user
  belongs_to :library
  belongs_to :invited_by, class_name: 'User'

  ### attributes

  enum role: { guest: 1, librarian: 2 }

  ### callbacks

  ### validations

  ### mix-in

  acts_as_paranoid

  ### scope

  ### methods

end
