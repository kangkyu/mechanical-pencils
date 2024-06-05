module ApplicationHelper

  def owned(user, item)
    user.owned(item)
  end

  def owned_with_proof(user, item)
    user.owned(item) && item.has_proof(user)
  end
end
