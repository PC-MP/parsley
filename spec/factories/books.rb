# frozen_string_literal: true

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
FactoryBot.define do
  factory :book do
    title     { Faker::Book.title }
    isbn13    { Faker::Code.isbn(base: 13) }
    isbn10    { Faker::Code.isbn }
    jan       { Faker::Code.ean }
    image_url { Faker::LoremFlickr.image }
    json      { Faker::Json.shallow_json(width: 3) }
  end
end
