module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate_token!

      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

      private

      def authenticate_token!
        token = extract_token_from_header
        @api_token = ApiToken.authenticate(token)

        if @api_token.nil?
          render json: { error: "Unauthorized" }, status: :unauthorized
        else
          @api_token.touch_last_used
        end
      end

      def current_user
        @current_user ||= @api_token&.user
      end

      def extract_token_from_header
        header = request.headers["Authorization"]
        header&.split(" ")&.last
      end

      def not_found
        render json: { error: "Not found" }, status: :not_found
      end

      def unprocessable_entity(exception)
        render json: { error: exception.record.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end
end
