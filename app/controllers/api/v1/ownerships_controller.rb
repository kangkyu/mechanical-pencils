module Api
  module V1
    class OwnershipsController < BaseController
      before_action :set_ownership

      def update
        if params[:proof].present?
          @ownership.proof.attach(params[:proof])
        end

        if @ownership.save
          render json: {
            ownership: ownership_json(@ownership),
            message: "Proof uploaded successfully"
          }
        else
          render json: { errors: @ownership.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_ownership
        @ownership = current_user.ownerships.find(params[:id])
      end

      def ownership_json(ownership)
        {
          id: ownership.id,
          item_id: ownership.item_id,
          has_proof: ownership.proof.attached?,
          proof_url: ownership.proof.attached? ? url_for(ownership.proof) : nil,
          created_at: ownership.created_at,
          updated_at: ownership.updated_at
        }
      end
    end
  end
end
