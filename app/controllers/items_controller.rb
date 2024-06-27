class ItemsController < ApplicationController
  before_action :ensure_login, only: [:new, :create, :own, :unown, :collection]
  before_action :ensure_admin, only: [:edit, :update, :destroy]

  def destroy
    @item = Item.find(params[:id])
    deleted = @item.destroy

    redirect_to items_url, status: :see_other, notice: "＂#{deleted.title}＂ deleted"
  end

  def edit
    @item = Item.find(params[:id])
    @makers = Maker.all
  end

  def update
    @item = Item.find(params[:id])
    group_ids = item_params.delete(:item_group_ids)
    if @item.update(item_params.except(:item_group_ids))
      (@item.item_group_ids - group_ids.map(&:to_i)).each do |group_id|
        if ItemGroup.exists?(group_id)
          Joiner.find_by(item_group_id: ItemGroup.find_by(id: group_id), item_id: @item).destroy
        end
      end
      (group_ids.map(&:to_i) - @item.item_group_ids).each do |group_id|
        if ItemGroup.exists?(group_id)
          if @item.item_group_ids.include?(group_id.to_i)
          else
            ItemGroup.find(group_id).items << @item
          end
        end
      end
      redirect_to item_url(@item)
    else
      render action: 'edit'
    end
  end

  def index
    @items = if params[:search].present?
        Item.order(:title).where('title LIKE ?', "%#{params[:search]}%")
      else
        Item.order(:title)
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
    params.require(:item).permit(:title, :maker_id, :image, :model_number, :tip_retractable, :eraser_attached, item_group_ids: [])
  end
end
