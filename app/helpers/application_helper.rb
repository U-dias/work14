module ApplicationHelper
  def avatar_url(user)
    if user.avatar.attached?
        url_for(user.avatar)
    else
        ActionController::Base.helpers.asset_path('default_icon.png')
    end
  end   
  def room_cover(room)
    if room.photo.attached?
        url_for(room.photo[0])
    else
        ActionController::Base.helpers.asset_path('default_room.png')
    end
  end
end

