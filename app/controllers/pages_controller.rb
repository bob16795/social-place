class PagesController < ApplicationController
  def index
  end

  def home
    if !user_signed_in?
      redirect_to "/"
    end
    @posts = Post.all
    @newPost = Post.new
  end

  def profile
    if (User.find_by_username(params[:id]))
      @username = params[:id]
    else
      redirect_to root_path, :notice=> "user not found!"
    end

    @posts = Post.all.where("user_id = ?", User.find_by_username(params[:id]).id)
    @newPost = Post.new
    @likes = Like.all.where("user_id = ?", User.find_by_username(params[:id]).id)
  end

  def post
    @p = Post.find(params[:id])
  end

  def explore
    @posts = Post.all
    @newPost = Post.new
  end

  def search
    if params[:search]
      @posts = Post.search(params[:search])
      @users = User.search(params[:search])
      @search = true
    else
      @search = false
    end
  end
end
