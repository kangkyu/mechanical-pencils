class Admin::ItemsController < Admin::BaseController
  def edit
    @item = Item.find(params[:id])
    @makers = Maker.all
    @influencers = Influencer.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_url(@item)
    else
      @makers = Maker.all
      @influencers = Influencer.all
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @item = Item.find(params[:id])
    deleted = @item.destroy
    redirect_to items_url, status: :see_other, notice: "\"#{deleted.title}\" deleted"
  end

  private

  def item_params
    params.require(:item).permit(:title, :maker_id, :image, :model_number, :category, :size, :color,
                                 :limited_edition, :shop_url, :official_url, :influencer_id)
  end
end
