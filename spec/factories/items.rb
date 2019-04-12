# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  discount_percentage :integer          default(0)
#  has_discount        :boolean          default(FALSE)
#  name                :string
#  original_price      :float            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryBot.define do
  factory :item do
    name { Faker::Cannabis.strain }
    original_price      { Faker::Number.decimal(2) }
    has_discount        { Faker::Boolean.boolean }
    discount_percentage { Faker::Number.number(2) }

    trait :with_discount do
      has_discount { true }
    end

    trait :without_discount do
      has_discount { false }
    end

    factory :item_with_discount, traits: %i[with_discount]
    factory :item_without_discount, traits: %i[without_discount]
  end
end
