class InfluencersController < ApplicationController
  def index
    @influencers = Influencer.order(:name)
  end

  def show
    @influencer = Influencer.find(params[:id])
    @items = @influencer.items.includes(:item_maker, image_attachment: :blob).order(:title)
  end
end
