# frozen_string_literal: true

# Book
#
# == Schema Information
#
# Table name: books
#
#  id           :integer          not null, primary key
#  title        :string(40)       not null
#  isbn13       :string(13)       not null
#  isbn10       :string(10)       not null
#  jan          :string(13)       not null
#  image_url    :string(255)
#  json         :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default("0")
#  deleted_at   :datetime
#
class Book < ApplicationRecord

  ### associations

  ### attributes

  ### callbacks

  ### validations

  validates :title,
            presence: true

  validates :isbn13,
            length:   { is: 13 },
            presence: true

  validates :isbn10,
            length:   { is: 10 },
            presence: true

  validates :jan,
            length:   { is: 13 },
            presence: true

  ### mix-in

  acts_as_paranoid

  ### methods

  def self.build_from_jancode(jan)
    info = jan2isbn10(jan)
    new(GoogleApi.fetch_and_map_book_info(info).merge(jan: jan))
  end

  def self.jan2isbn10(input)
    sum = 0
    code = input[3, 9]
    code.split('').reverse.each_with_index { |item, no| sum += item.to_i * (no + 2) }
    code + (11 - (sum % 11)).to_s
  end
end
