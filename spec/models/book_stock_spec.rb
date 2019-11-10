# frozen_string_literal: true

require 'rails_helper'

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
RSpec.describe BookStock, type: :model do
  subject(:described_instance) { FactoryBot.build :book_stock }

  describe 'db index' do
    it { is_expected.to have_db_index(:book_id) }
    it { is_expected.to have_db_index(:library_id) }
  end

  describe 'attributes' do
    it { is_expected.to respond_to :jan_code }
    it { is_expected.to respond_to :jan_code= }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:book) }
    it { is_expected.to belong_to(:library) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:stock) }
    it { is_expected.to validate_numericality_of(:stock).is_greater_than(0).is_less_than(10) }
  end
end
