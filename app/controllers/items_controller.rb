class ItemsController < ApplicationController
  before_action :ensure_login, only: %i[new create own unown]

  def index
    base_scope = Item
      .includes(:item_maker, image_attachment: :blob)
      .with_title(params[:search])
      .order(:title)

    @pagy, @items = pagy(base_scope, limit: 8)

    # Pre-load ownership counts to avoid N+1 queries
    @ownership_counts = Ownership.where(item_id: @items.map(&:id)).group(:item_id).count

    # Pre-load owned item IDs for current user
    if signed_in?
      @owned_item_ids = current_user.ownerships.where(item_id: @items.map(&:id)).pluck(:item_id).to_set
    else
      @owned_item_ids = Set.new
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_url, status: :see_other
    else
      @makers = Maker.all
      render :new, status: :unprocessable_content
    end
  end

  def new
    @item = Item.new
    @makers = Maker.all
  end

  def show
    @item = Item.includes(
      :item_maker,
      :item_groups,
      image_attachment: :blob,
      ownerships: [:user, proof_attachment: :blob]
    ).find(params[:id])

    # Pre-load user's ownership if signed in
    if signed_in?
      @user_ownership = @item.ownerships.find { |o| o.user_id == current_user.id }
    end
  end

  def collection
    if signed_in?
      @user_items = current_user.items
      @item_groups = current_user.item_groups.reorder(:title).distinct
    else
      redirect_to new_session_url, notice: "Forgot to login? This page is for your list of collection"
    end
  end

  def own
    @item = Item.find(params[:id])
    current_user.ownerships.create(item: @item) unless current_user.owned(@item)
    redirect_to @item
  end

  def unown
    @item = Item.find(params[:id])
    Ownership.where(user: current_user, item: @item).last.destroy if current_user.owned(@item)
    redirect_to @item
  end

  private

  def item_params
    params.require(:item).permit(:title, :maker_id, :image, :model_number, :tip_retractable, :eraser_attached,
                                 :jetpens_url, :blick_url)
  end
end
