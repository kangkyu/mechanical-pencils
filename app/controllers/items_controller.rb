class ItemsController < ApplicationController
  before_action :ensure_login, only: [:new, :create]

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
    if signed_in?
      @items = current_user.items.order(created_at: :desc)
    else
      redirect_to new_session_url, notice: "Forgot to login? This page is for your list of collection"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image)
  end
end
