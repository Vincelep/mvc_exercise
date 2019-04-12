# frozen_string_literal: true

require 'faker'

1.upto(10) do |i|
  Item.create!(
    original_price: Faker::Number.decimal(2), name: Faker::Cannabis.strain
  )
  p "ITEM #{i} : créé"
end
