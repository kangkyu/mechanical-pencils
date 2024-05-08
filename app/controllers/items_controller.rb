class ItemsController < ApplicationController
  before_action :ensure_login, only: [:new, :create, :collection]

  def index
    @items = Item.order(created_at: :desc)
  end

  def create
    item = Item.new(item_params)
    if item.save!
      redirect_to items_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def collection
    @items = current_user.items.order(created_at: :desc)
  end

  private

  def item_params
    params.require(:item).permit(:name, :image)
  end
end
