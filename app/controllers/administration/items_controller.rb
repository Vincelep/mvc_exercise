# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    def index
      @emails = User.emails_of_all_users
      @items = Item.all
    end

    def update
      @item = Item.find(params[:id])
      @item.update(has_discount: true, discount_percentage: params[:item]['discount_percentage']) if params[:item]['discount_percentage'] != 0
      flash[:notice] = "L'item a bien été modifié."
      redirect_to administration_items_path
    end
  end
end
