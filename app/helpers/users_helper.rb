module UsersHelper
  
  def admin_situation?(user)
    if user.admin == "true"
      return true
    else
      return false
    end
  end
  
end
