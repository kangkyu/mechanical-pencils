module Api
  module V1
    class InfluencersController < BaseController
      def index
        @influencers = Influencer.order(:name)

        render json: {
          influencers: @influencers.map { |influencer| influencer_json(influencer) }
        }
      end

      def show
        @influencer = Influencer.find(params[:id])

        render json: {
          influencer: influencer_detail_json(@influencer)
        }
      end

      def create
        @influencer = if params[:influencer][:channel_uuid].present?
          Influencer.find_or_initialize_by(identifier: params[:influencer][:channel_uuid])
        else
          Influencer.find_or_initialize_by(handle: influencer_params[:handle])
        end
        @influencer.assign_attributes(influencer_params)
        @influencer.identifier ||= params[:influencer][:channel_uuid]

        if @influencer.save
          render json: { influencer: influencer_json(@influencer) }, status: :created
        else
          render json: { errors: @influencer.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def influencer_params
        params.require(:influencer).permit(:name, :platform, :handle, :profile_url)
      end

      def influencer_json(influencer)
        {
          id: influencer.id,
          name: influencer.name,
          platform: influencer.platform,
          handle: influencer.handle,
          avatar_url: influencer.avatar.attached? ? url_for(influencer.avatar.variant(:thumb)) : nil,
          items_count: influencer.items.count
        }
      end

      def influencer_detail_json(influencer)
        {
          id: influencer.id,
          name: influencer.name,
          bio: influencer.bio,
          platform: influencer.platform,
          handle: influencer.handle,
          profile_url: influencer.profile_url,
          follower_count: influencer.follower_count,
          avatar_url: influencer.avatar.attached? ? url_for(influencer.avatar) : nil,
          items: influencer.items.includes(:item_maker, image_attachment: :blob).map { |item| item_json(item) }
        }
      end

      def item_json(item)
        {
          id: item.id,
          title: item.title,
          maker: item.item_maker&.title,
          model_number: item.model_number,
          image_url: item.image.attached? ? url_for(item.image.variant(:thumb)) : nil
        }
      end
    end
  end
end
