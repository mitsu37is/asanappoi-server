# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "test task #{n}" }
    description 'This is a detail for test task.'
    completed false
  end
end
