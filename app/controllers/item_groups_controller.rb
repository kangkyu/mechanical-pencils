class ItemGroupsController < ApplicationController
  def show
    @item_group = ItemGroup.find(params[:id])
  end
end
