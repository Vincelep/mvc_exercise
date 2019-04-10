# frozen_string_literal: true

class ItemsController < ApplicationController
  def index
    @emails = User.emails_of_all_users
    @items = Item.all
  end
end
