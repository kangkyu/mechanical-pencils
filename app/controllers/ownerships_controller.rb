class OwnershipsController < ApplicationController
  def new
    @item = Item.find_by(id: params[:item_id])
    @ownership = @item.ownerships.build(user_id: current_user)
  end

  def create
    @item = Item.find_by(id: params[:item_id])
    @ownership = Ownership.build(ownership_params)
    if @ownership.save!
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def ownership_params
    params.require(:ownership).permit(:proof).merge(user_id: current_user.id).merge(item_id: params[:item_id])
  end
end
