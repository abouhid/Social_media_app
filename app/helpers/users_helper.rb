module UsersHelper
  def friendship_requested?(user)
    friends_array = friendships.map { |friendship| friendship.friend unless friendship.confirmed }
    friends_array.include?(user)
  end

  def friend_status(user, current_user)
    user.friendship_requested?(current_user)
  end

  def friend_or_friendship_requested(user, current_user)
    current_user.friendship_requested?(user) || current_user.friend?(user)
  end
end
