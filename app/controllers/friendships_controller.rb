class FriendshipsController < ApplicationController
  def new
    @friendship_created = current_user.friendships.build
  end

  def create
    @friendship_created = current_user.friendships.build
    @friendship_created.friend_id = params[:user_id]

    if @friendship_created.save
      redirect_to users_path, notice: 'Friend Added'
    else
      redirect_to users_path, notice: @friendship_created.errors.full_messages
    end
  end

  private

  def friendship_params
    params.require(:friendships).permit(:friend_id, :user_id)
  end
end
