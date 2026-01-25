module Api
  module V1
    class ItemGroupsController < BaseController
      def index
        @item_groups = ItemGroup.order(:title)

        render json: {
          item_groups: @item_groups.map { |group| item_group_json(group) }
        }
      end

      def show
        @item_group = ItemGroup.find(params[:id])

        render json: {
          item_group: item_group_detail_json(@item_group)
        }
      end

      private

      def item_group_json(group)
        {
          id: group.id,
          title: group.title,
          link: group.link,
          items_count: group.items.count
        }
      end

      def item_group_detail_json(group)
        {
          id: group.id,
          title: group.title,
          link: group.link,
          items: group.items.map { |item| item_json(item) }
        }
      end

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
    end
  end
end
