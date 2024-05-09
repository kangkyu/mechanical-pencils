module ApplicationHelper

  def owned(user, item)
    user.owned(item)
  end
end
