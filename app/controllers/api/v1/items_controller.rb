module Api
  module V1
    class ItemsController < BaseController
      include Pagy::Backend

      def index
        @pagy, @items = pagy(Item.with_title(params[:search]).order(:title), limit: params[:per_page] || 20)

        render json: {
          items: @items.map { |item| item_json(item) },
          pagination: pagination_json(@pagy)
        }
      end

      def show
        @item = Item.find(params[:id])

        render json: {
          item: item_detail_json(@item)
        }
      end

      def own
        @item = Item.find(params[:id])

        unless current_user.owned(@item)
          ownership = current_user.ownerships.create!(item: @item)
        end

        render json: {
          item: item_detail_json(@item),
          message: "Item added to collection"
        }, status: :created
      end

      def unown
        @item = Item.find(params[:id])

        if current_user.owned(@item)
          Ownership.where(user: current_user, item: @item).last.destroy
        end

        render json: {
          item: item_detail_json(@item),
          message: "Item removed from collection"
        }
      end

      private

      def item_json(item)
        {
          id: item.id,
          title: item.title,
          maker: item.item_maker&.title,
          model_number: item.model_number,
          image_url: item.image.attached? ? url_for(item.image.variant(:thumb)) : nil,
          owned: current_user.owned(item)
        }
      end

      def item_detail_json(item)
        {
          id: item.id,
          title: item.title,
          description: item.description,
          maker: maker_json(item.item_maker),
          model_number: item.model_number,
          tip_retractable: item.tip_retractable,
          eraser_attached: item.eraser_attached,
          jetpens_url: item.jetpens_url,
          blick_url: item.blick_url,
          image_url: item.image.attached? ? url_for(item.image) : nil,
          thumbnail_url: item.image.attached? ? url_for(item.image.variant(:thumb)) : nil,
          owned: current_user.owned(item),
          has_proof: item.has_proof(current_user),
          ownership_id: current_user.ownerships.find_by(item: item)&.id,
          created_at: item.created_at,
          updated_at: item.updated_at
        }
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
