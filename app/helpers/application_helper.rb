module ApplicationHelper
  def avatar_url user
    if (user.id < 4 && user.id > 0)
      return "pb#{user.id}.png"
    else
      return "templatePB.png"
    end
  end
end
