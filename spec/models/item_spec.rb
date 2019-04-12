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

require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.create(:item)
  end

  it "has a valid factory" do
    expect(build(:item)).to be_valid
  end

  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean).with_options(default: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer).with_options(null: true) }
    end
  end

  context "with validation attributes" do
    let(:item) { build(:item) }

    it "is valid with valid attributes" do
      expect(item).to be_a(Item)
    end

    describe "original_price" do
      it { expect(item).to validate_presence_of(:original_price) }
      it { expect(item).to validate_numericality_of(:original_price).is_greater_than(0) }
    end

    describe "has_discount" do
      it { is_expected.not_to allow_value(nil).for(:has_discount) }
    end

    describe "discount_percentage" do
      it { expect(item).to validate_numericality_of(:discount_percentage).only_integer }
      it { is_expected.to validate_inclusion_of(:discount_percentage).in_range(1..99) }
    end
  end

  describe 'Price' do
    context 'when the item has a discount' do
      let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
    end

    context 'when the item has no discount' do
      let(:item) { build(:item_without_discount, original_price: 50.00) }

      it { expect(item.price).to eq(50.00) }
      it { expect(item.has_discount).to be(false) }
    end
  end
end
