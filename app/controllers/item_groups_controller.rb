class ItemGroupsController < ApplicationController
  def index
    @item_groups = ItemGroup.order(:title)
  end

  def show
    @item_group = ItemGroup.find(params[:id])
  end
end
