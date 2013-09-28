module UsersHelper

  def full_name_of(user)
    "#{user.first_name} #{user.last_name}"
  end

end
