class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_param)
    @post.user_id = current_user.id
    respond_to do |t|
      if (@post.save)
        t.html { redirect_to "", notice: "Post Completed" }
      else
        t.html { redirect_to "", notice: "ERROR:not posted"}
      end
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.posts.find(post.id).destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def post_param
    params.require(:post).permit(:User_id, :content)
  end
end
