class Admin::InfluencersController < Admin::BaseController
  def new
    @influencer = Influencer.new
  end

  def create
    @influencer = Influencer.new(influencer_params)
    if @influencer.save
      redirect_to influencer_url(@influencer), status: :see_other
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @influencer = Influencer.find(params[:id])
  end

  def update
    @influencer = Influencer.find(params[:id])
    if @influencer.update(influencer_params)
      redirect_to influencer_url(@influencer)
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @influencer = Influencer.find(params[:id])
    deleted = @influencer.destroy
    redirect_to influencers_url, status: :see_other, notice: "\"#{deleted.name}\" deleted"
  end

  private

  def influencer_params
    params.require(:influencer).permit(:name, :bio, :platform, :handle, :profile_url, :follower_count, :avatar)
  end
end
