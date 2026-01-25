class Admin::ItemGroupsController < Admin::BaseController
  def new
    @item_group = ItemGroup.new
    @items = Item.order(:title)
  end

  def create
    @item_group = ItemGroup.new(item_group_params)
    if @item_group.save
      if params[:item_group][:item_ids].present?
        params[:item_group][:item_ids].compact_blank.each do |item_id|
          @item_group.items << Item.find(item_id)
        end
      end
      redirect_to item_group_path(@item_group), notice: "Item group created successfully."
    else
      @items = Item.order(:title)
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @item_group = ItemGroup.find(params[:id])
    @items = Item.order(:title)
  end

  def update
    @item_group = ItemGroup.find(params[:id])
    if @item_group.update(item_group_params)
      # Update items association
      item_ids = params[:item_group][:item_ids]&.reject(&:blank?)&.map(&:to_i) || []
      @item_group.item_ids = item_ids
      redirect_to item_group_path(@item_group), notice: "Item group updated successfully."
    else
      @items = Item.order(:title)
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @item_group = ItemGroup.find(params[:id])
    @item_group.destroy
    redirect_to item_groups_path, notice: "Item group deleted.", status: :see_other
  end

  private

  def item_group_params
    params.require(:item_group).permit(:title, :link)
  end
end
