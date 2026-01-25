module Api
  module V1
    class UsersController < BaseController
      def show
        @user = User.find(params[:id])
        @items = @user.items.includes(:item_maker)

        render json: {
          user: user_json(@user),
          items: @items.map { |item| item_with_proof_json(item, @user) },
          total_count: @items.count
        }
      end

      private

      def user_json(user)
        {
          id: user.id,
          email: user.email
        }
      end

      def item_with_proof_json(item, user)
        ownership = user.ownerships.find_by(item: item)
        {
          id: item.id,
          title: item.title,
          maker: item.item_maker&.title,
          model_number: item.model_number,
          image_url: item.image.attached? ? url_for(item.image.variant(:thumb)) : nil,
          has_proof: ownership&.proof&.attached? || false,
          proof_url: ownership&.proof&.attached? ? url_for(ownership.proof) : nil
        }
      end
    end
  end
end
