class ItemsController < ApplicationController
  before_action :ensure_login, only: [:new, :create, :own, :unown]
  before_action :ensure_admin, only: [:edit, :update]

  def destroy
    @item = Item.find(params[:id])
    deleted = @item.destroy

    redirect_to items_url, status: :see_other, notice: "＂#{deleted.title}＂ deleted"
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_url(@item)
    else
      render action: 'edit'
    end
  end

  def index
    @items = if params[:search].present?
        Item.order(created_at: :desc).where('title LIKE ?', "%#{params[:search]}%")
      else
        Item.order(created_at: :desc)
      end
  end

  def create
    item = Item.new(item_params)
    if item.save!
      redirect_to items_url, status: :see_other
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
      @user_items = current_user.items.order(created_at: :desc)
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
    params.require(:item).permit(:title, :maker, :image)
  end
end
