module Api
  module V1
    class SessionsController < BaseController
      skip_before_action :authenticate_token!, only: [:create]

      def create
        user = User.find_by(email: params[:email]&.downcase)

        if user&.authenticate(params[:password])
          api_token = user.api_tokens.create!(expires_at: 30.days.from_now)

          render json: {
            token: api_token.raw_token,
            user: user_json(user)
          }, status: :created
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end

      def destroy
        @api_token.destroy
        render json: { message: "Logged out successfully" }, status: :ok
      end

      private

      def user_json(user)
        {
          id: user.id,
          email: user.email,
          admin: user.admin?
        }
      end
    end
  end
end
