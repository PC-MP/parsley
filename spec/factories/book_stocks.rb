# frozen_string_literal: true

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
FactoryBot.define do
  factory :book_stock do
    association :library
    association :book
    stock { rand(1..5) }
  end
end
