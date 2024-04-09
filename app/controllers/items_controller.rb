class ItemsController < ApplicationController
  def index
    @items = Item.order(created_at: :desc)
  end
end
