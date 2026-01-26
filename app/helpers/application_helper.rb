module ApplicationHelper
  include Pagy::Frontend

  def owned(user, item)
    Ownership.exists? item_id: item, user_id: user
  end

  def owned_with_proof(user, item)
    Ownership.where(item_id: item, user_id: user).joins(:proof_attachment).exists?
  end
end
