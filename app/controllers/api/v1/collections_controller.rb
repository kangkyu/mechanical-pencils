module Api
  module V1
    class CollectionsController < BaseController
      def show
        @items = current_user.items.includes(:item_maker)
        @item_groups = current_user.item_groups.order(:title).distinct
        @ownerships_by_item_id = current_user.ownerships
          .where(item_id: @items.select(:id))
          .includes(proof_attachment: :blob)
          .index_by(&:item_id)

        render json: {
          items: @items.map { |item| item_with_ownership_json(item) },
          item_groups: @item_groups.map { |group| item_group_json(group) },
          total_count: @items.count
        }
      end

      private

      def item_with_ownership_json(item)
        ownership = @ownerships_by_item_id[item.id]
        {
          id: item.id,
          title: item.title,
          maker: item.item_maker&.title,
          model_number: item.model_number,
          image_url: item.image.attached? ? url_for(item.image.variant(:thumb)) : nil,
          ownership_id: ownership&.id,
          has_proof: ownership&.proof&.attached? || false,
          proof_url: ownership&.proof&.attached? ? url_for(ownership.proof) : nil,
          owned_at: ownership&.created_at
        }
      end

      def item_group_json(group)
        {
          id: group.id,
          title: group.title
        }
      end
    end
  end
end
