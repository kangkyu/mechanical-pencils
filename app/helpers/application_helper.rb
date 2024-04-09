module ApplicationHelper

  def owned(user, item)
    user.items.exists? item.id
  end
end
