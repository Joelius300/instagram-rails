module ApplicationHelper
  def avatar_url user
    img = "pb#{user.id}.jpg"
    if FileTest.exist?("#{::Rails.root}/public/images/#{img}")
      image-url(img)
    else
      image-url("templatePB.png")
    end
  end
end
