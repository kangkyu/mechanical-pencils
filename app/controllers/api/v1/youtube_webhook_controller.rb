module Api
  module V1
    class YoutubeWebhookController < BaseController
      skip_before_action :authenticate_token!
      before_action :authenticate_webhook!

      def create
        if params[:influencer].present?
          influencer = Influencer.find_or_initialize_by(identifier: params[:influencer][:channel_uuid])
          influencer.assign_attributes(influencer_params)
          influencer.identifier ||= params[:influencer][:channel_uuid]
          influencer.platform ||= "YouTube"
          influencer.save!
        end

        if params[:item].present?
          item = Item.where("data->>'amazon_url' = ?", item_params[:amazon_url]).first_or_initialize
          item.amazon_url ||= item_params[:amazon_url]
          item.title ||= item_params[:title] || title_from_url(item_params[:amazon_url])
          item.item_maker ||= Maker.find_or_create_by!(title: "Unknown")
          item.save!

          if item_params[:channel_uuid].present?
            item_influencer = Influencer.find_or_create_by!(identifier: item_params[:channel_uuid]) do |i|
              i.identifier = item_params[:channel_uuid]
              i.platform = "YouTube"
            end
            item.influencers << item_influencer unless item.influencers.include?(item_influencer)
          end
        end

        head :ok
      end

      private

      def authenticate_webhook!
        token = request.headers["Authorization"]&.split(" ")&.last
        unless ActiveSupport::SecurityUtils.secure_compare(token.to_s, ENV["WEBHOOK_SECRET"])
          render json: { error: "Unauthorized" }, status: :unauthorized
        end
      end

      def influencer_params
        params.require(:influencer).permit(:name, :platform, :handle, :profile_url)
      end

      def item_params
        params.require(:item).permit(:amazon_url, :title, :channel_uuid)
      end

      def title_from_url(url)
        path = URI.parse(url).path
        slug = path.split("/").find { |seg| seg.match?(/[a-zA-Z].*-/) }
        slug&.tr("-", " ")&.strip || url
      rescue URI::InvalidURIError
        url
      end
    end
  end
end
