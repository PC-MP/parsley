# frozen_string_literal: true

# BookStock
#
# == Schema Information
#
# Table name: book_stocks
#
#  id           :integer          not null, primary key
#  book_id      :integer          not null
#  library_id   :integer          not null
#  stock        :integer          default("1"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default("0")
#  deleted_at   :datetime
#
# Indexes
#
#  index_book_stocks_on_book_id     (book_id)
#  index_book_stocks_on_library_id  (library_id)
#
class BookStock < ApplicationRecord

  ### associations

  belongs_to :book
  belongs_to :library

  ### attributes

  attr_accessor :jan_code

  ### callbacks

  ### validations

  validates :stock,
            numericality: { greater_than: 0, less_than: 10 },
            presence:     true

  ### mix-in

  acts_as_paranoid

  ### methods

end
