module Api
  module V1
    class MesController < BaseController
      def show
        render json: { email: current_user.email }, status: :ok
      end
    end
  end
end
