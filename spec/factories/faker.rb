# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  sequence(:username) { Faker::Internet.username }
  sequence(:domain)   { Faker::Internet.domain_name }
end
