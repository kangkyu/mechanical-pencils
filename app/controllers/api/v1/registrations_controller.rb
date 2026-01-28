module Api
  module V1
    class RegistrationsController < BaseController
      skip_before_action :authenticate_token!, only: [:create]

      def create
        user = User.new(user_params)

        if user.save
          api_token = user.api_tokens.create!(expires_at: 30.days.from_now)

          render json: {
            token: api_token.raw_token,
            user: {
              id: user.id,
              email: user.email,
              admin: user.admin?
            }
          }, status: :created
        else
          render json: { error: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation).tap do |p|
          p[:email] = p[:email]&.downcase
        end
      end
    end
  end
end
