# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                     :bigint(8)        not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_confirmation_token    (confirmation_token) UNIQUE
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#

require 'rails_helper'

RSpec.describe Admin, type: :model do
  before do
    @admin = FactoryBot.create(:admin)
  end

  it "has a valid factory" do
    expect(build(:admin)).to be_valid
  end

  describe 'Model instantiation' do
    subject(:new_admin) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer).with_options(null: false) }
      it { is_expected.to have_db_column(:confirmation_sent_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:confirmation_token).of_type(:string) }
      it { is_expected.to have_db_column(:confirmed_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:email).of_type(:string).with_options(default: "").with_options(null: false) }
      it { is_expected.to have_db_column(:encrypted_password).of_type(:string).with_options(default: "").with_options(null: false) }
      it { is_expected.to have_db_column(:remember_created_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime) }
      it { is_expected.to have_db_column(:reset_password_token).of_type(:string) }
      it { is_expected.to have_db_column(:unconfirmed_email).of_type(:string) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

  context "with validations" do
    let(:admin) { build(:admin) }

    it "is valid with valid attributes" do
      expect(admin).to be_a(Admin)
    end

    describe "email" do
      it { expect(admin).to validate_presence_of(:email) }
      it { expect(admin).to validate_uniqueness_of(:email).case_insensitive }
      it { is_expected.not_to allow_value("foo").for(:email) }
      # it { is_expected.not_to allow_value("jean@example.com").for(:email) }
    end

    describe "password" do
      it { expect(admin).to validate_presence_of(:password) }
      it { is_expected.to validate_length_of(:password).is_at_least(6) }
    end
  end
end
