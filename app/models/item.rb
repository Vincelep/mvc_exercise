# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Item < ApplicationRecord
  def price
    if has_discount
      (original_price - (original_price * discount_percentage / 100)).round(2)
    else
      original_price
    end
  end

  def self.average_price
    items = Item.all
    sum = 0
    items.each do |item|
      item.price
      sum += item.price / items.count
    end
    sum.round(2)
  end
end
