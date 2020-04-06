class BlocksController < ApplicationController
  def create
    user = User.find(params[:blocked_id])
    current_user.block(user)
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    user = User.find(params[:blocked_id])
    current_user.unblock(user)
    redirect_back(fallback_location: root_path)
  end
end
