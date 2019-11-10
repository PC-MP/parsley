# frozen_string_literal: true

require 'rails_helper'

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
RSpec.describe Book, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:isbn13) }
    it { is_expected.to validate_length_of(:isbn13).is_equal_to(13) }
    it { is_expected.to validate_presence_of(:isbn10) }
    it { is_expected.to validate_length_of(:isbn10).is_equal_to(10) }
    it { is_expected.to validate_presence_of(:jan) }
    it { is_expected.to validate_length_of(:jan).is_equal_to(13) }
  end
end
