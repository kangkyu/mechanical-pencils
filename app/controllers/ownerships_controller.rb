class OwnershipsController < ApplicationController
  def edit
    @item = Item.find_by(id: params[:item_id])
    @ownership = @item.ownerships.find_by(user_id: current_user)
  end

  def update
    @item = Item.find_by(id: params[:item_id])
    @ownership = @item.ownerships.find_by(user_id: current_user)

    if @ownership.update(ownership_params)
      redirect_to @item
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def ownership_params
    params.require(:ownership).permit(:proof)
  end
end
