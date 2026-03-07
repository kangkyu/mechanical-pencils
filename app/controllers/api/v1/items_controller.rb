module Api
  module V1
    class ItemsController < BaseController
      include Pagy::Backend

      def index
        base_scope = Item
          .includes(:item_maker, :influencers, image_attachment: :blob)
          .with_title(params[:search])
          .order(:title)

        @pagy, @items = pagy(base_scope, limit: params[:per_page] || 20)

        # Pre-load owned item IDs to avoid N+1 queries
        @owned_item_ids = current_user.ownerships
          .where(item_id: @items.map(&:id))
          .pluck(:item_id)
          .to_set

        render json: {
          items: @items.map { |item| item_json(item) },
          pagination: pagination_json(@pagy)
        }
      end

      def show
        @item = Item.includes(:item_maker, :influencers, image_attachment: :blob).find(params[:id])

        # Pre-load ownership data to avoid multiple queries
        @user_ownership = current_user.ownerships.includes(proof_attachment: :blob).find_by(item: @item)
        @item_ownerships = @item.ownerships.includes(:user, proof_attachment: :blob).to_a

        render json: {
          item: item_detail_json(@item)
        }
      end

      def create
        item = Item.where("data->>'amazon_url' = ?", item_params[:amazon_url]).first_or_initialize
        item.amazon_url ||= item_params[:amazon_url]
        item.title ||= item_params[:title] || title_from_url(item_params[:amazon_url])
        item.item_maker ||= Maker.find_or_create_by!(title: "Unknown")

        was_new = item.new_record?
        if item.save
          if item_params[:channel_uuid].present?
            influencer = Influencer.find_or_create_by!(handle: item_params[:channel_uuid]) do |i|
              i.name = item_params[:channel_uuid]
              i.platform = "YouTube"
            end
            item.influencers << influencer unless item.influencers.include?(influencer)
          end
          render json: { item: { id: item.id, amazon_url: item.amazon_url } }, status: was_new ? :created : :ok
        else
          render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def own
        @item = Item.includes(:item_maker, :influencers, image_attachment: :blob).find(params[:id])

        @user_ownership = current_user.ownerships.find_by(item: @item)
        unless @user_ownership
          @user_ownership = current_user.ownerships.create!(item: @item)
        end

        @item_ownerships = @item.ownerships.includes(:user, proof_attachment: :blob).to_a

        render json: {
          item: item_detail_json(@item),
          message: "Item added to collection"
        }, status: :created
      end

      def unown
        @item = Item.includes(:item_maker, :influencers, image_attachment: :blob).find(params[:id])

        ownership_to_destroy = current_user.ownerships.find_by(item: @item)
        ownership_to_destroy&.destroy

        @user_ownership = nil
        @item_ownerships = @item.ownerships.includes(:user, proof_attachment: :blob).to_a

        render json: {
          item: item_detail_json(@item),
          message: "Item removed from collection"
        }
      end

      private

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

      def item_json(item)
        {
          id: item.id,
          title: item.title,
          maker: item.item_maker&.title,
          model_number: item.model_number,
          influencers: item.influencers.map(&:name),
          image_url: item.image.attached? ? url_for(item.image.variant(:thumb)) : nil,
          owned: @owned_item_ids.include?(item.id)
        }
      end

      def item_detail_json(item)
        {
          id: item.id,
          title: item.title,
          description: item.description,
          maker: maker_json(item.item_maker),
          model_number: item.model_number,
          category: item.category,
          size: item.size,
          color: item.color,
          limited_edition: item.limited_edition,
          amazon_url: item.amazon_url,
          official_url: item.official_url,
          jetpens_url: item.jetpens_url,
          blick_url: item.blick_url,
          influencers: item.influencers.map { |i| influencer_json(i) },
          image_url: item.image.attached? ? url_for(item.image) : nil,
          thumbnail_url: item.image.attached? ? url_for(item.image.variant(:thumb)) : nil,
          owned: @user_ownership.present?,
          has_proof: @user_ownership&.proof&.attached? || false,
          ownership_id: @user_ownership&.id,
          proofs: item_proofs_json,
          owners_count: @item_ownerships.size,
          created_at: item.created_at,
          updated_at: item.updated_at
        }
      end

      def item_proofs_json
        @item_ownerships.select { |o| o.proof.attached? }.map do |ownership|
          {
            id: ownership.id,
            user_id: ownership.user.id,
            user_email: ownership.user.email,
            proof_url: url_for(ownership.proof),
            created_at: ownership.created_at
          }
        end
      end

      def maker_json(maker)
        return nil unless maker
        {
          id: maker.id,
          title: maker.title,
          origin: maker.origin,
          homepage: maker.homepage
        }
      end

      def influencer_json(influencer)
        return nil unless influencer
        {
          id: influencer.id,
          name: influencer.name,
          platform: influencer.platform,
          handle: influencer.handle
        }
      end

      def pagination_json(pagy)
        {
          current_page: pagy.page,
          total_pages: pagy.pages,
          total_count: pagy.count,
          per_page: pagy.limit
        }
      end
    end
  end
end
