module ApplicationHelper
  include Pagy::Frontend

  def owned(user, item)
    Ownership.exists? item_id: item, user_id: user
  end

  def owned_with_proof(user, item)
    owned(user, item) && Ownership.where(item_id: item, user_id: user).any? { |o| o.proof.attached? }
  end
end
