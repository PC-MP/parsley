# frozen_string_literal: true

# InvitationTicket
#
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
class InvitationTicket < ApplicationRecord
  include ExpiredScope

  ### associations

  belongs_to :library

  ### attributes

  ### callbacks

  before_validation :set_defaults, on: :create

  ### validations

  validates :ticket_hash,
            length:   { is: 16 },
            format:   { with: /\A[a-zA-Z0-9]+\z/ },
            presence: true

  ### mix-in

  acts_as_paranoid

  ### scope

  ### methods

  private

  def set_defaults
    self.ticket_hash ||= SecureRandom.alphanumeric 16
  end
end
