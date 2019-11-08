# frozen_string_literal: true

# User
class User < ApplicationRecord

  ### associations

  ### callbacks

  ### validations

  validates :username,
            presence: true,
            length:   { in: 2..40 }

  validates :email,
            presence:   true,
            uniqueness: { case_sensitive: false }

  validates :password,
            presence:     true,
            confirmation: true,
            length:       { minimum: 8, maximum: 120 },
            on:           :create

  validates :password,
            confirmation: true,
            length:       { minimum: 8, maximum: 120 },
            on:           :update,
            allow_blank:  true

  ### mix-in

  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :validatable

  ### methods

end
