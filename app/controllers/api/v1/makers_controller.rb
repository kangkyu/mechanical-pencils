module Api
  module V1
    class MakersController < BaseController
      def index
        @makers = Maker.order(:title)

        render json: {
          makers: @makers.map { |maker| maker_json(maker) }
        }
      end

      private

      def maker_json(maker)
        {
          id: maker.id,
          title: maker.title,
          origin: maker.origin,
          homepage: maker.homepage,
          items_count: maker.items.count
        }
      end
    end
  end
end
