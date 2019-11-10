# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  sequence(:username)   { Faker::Internet.username }
  sequence(:domain)     { Faker::Internet.domain_name }
  sequence(:group_name) { Faker::Games::Pokemon.location }
  sequence(:display_name) { Faker::Name.name }
  sequence(:library_name) { Faker::University.name }
  sequence(:icon_url) { Faker::Avatar.image(size: '48x48') }
end
