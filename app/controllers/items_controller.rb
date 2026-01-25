class ItemsController < ApplicationController
  before_action :ensure_login, only: [:new, :create, :own, :unown]

  def index
    @pagy, @items = pagy(Item.with_title(params[:search]).order(:title), limit: 8)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_url, status: :see_other
    else
      @makers = Maker.all
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @item = Item.new
    @makers = Maker.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def collection
    if signed_in?
      @user_items = current_user.items
      @item_groups = current_user.item_groups.order(:title).uniq
    else
      redirect_to new_session_url, notice: "Forgot to login? This page is for your list of collection"
    end
  end

  def own
    @item = Item.find(params[:id])
    if !current_user.owned(@item)
      current_user.ownerships.create(item: @item)
    end
    redirect_to @item
  end

  def unown
    @item = Item.find(params[:id])
    if current_user.owned(@item)
      Ownership.where(user: current_user, item: @item).last.destroy
    end
    redirect_to @item
  end

  private

  def item_params
    params.require(:item).permit(:title, :maker_id, :image, :model_number, :tip_retractable, :eraser_attached, :jetpens_url, :blick_url)
  end
end
