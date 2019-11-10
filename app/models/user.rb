# frozen_string_literal: true

# User
#
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
class User < ApplicationRecord

  ### associations

  belongs_to :group

  has_many :libraries, dependent: :destroy
  has_many :roles,     dependent: :destroy

  ### attributes

  ### callbacks

  before_validation :create_group, on: :create
  after_create      :create_owner_role

  ### validations

  validates :username,
            presence: true,
            length:   { in: 2..40 }

  ### mix-in

  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable, :timeoutable,
  #        :recoverable, :rememberable, :validatable
  devise :lockable, :timeoutable, :trackable, :omniauthable

  ### methods

  def role_for(library)
    return :owner if library.user_id == id

    group_role = library.group.roles.find_by(user_id: id)&.role
    return group_role.to_sym if group_role

    invited_role = library.invitations.find_by(user_id: id)&.role
    return invited_role.to_sym if invited_role

    nil
  end

  private

  def create_group
    self.group = Group.create!(name: username)
  end

  def create_owner_role
    Role.create_with(role: :owner).find_or_create_by!(user_id: id, group_id: group.id)
  end

end
