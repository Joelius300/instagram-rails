class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [:show, :destroy]

  def index
      @posts = Post.all.limit(10).includes(:photos, :user).order('created_at desc')
      @post = Post.new
  end

  def create
    if params[:images].empty?
      flash[:alert] = "You need to add a picture!"
      return
    end

    @post = current_user.posts.build(post_params)
    if @post.save
        if params[:images]
            params[:images].each do |img|
                @post.photos.create(image: img[1])
            end
        end

        flash[:notice] = "Saved ..."
        redirect_to posts_path
    else
        flash[:alert] = "Something went wrong ..."
        redirect_to posts_path
    end
  end

  def show
    @photos = @post.photos
  end

  def destroy
    if @post.user == current_user
      if @post.destroy
        flash[:notice] = "Post deleted!"
      else
        flash[:alert] = "Something went wrong ..."
      end
    else
      flash[:alert] = "You dont have permission to delete this post!"
    end

    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find_by id: params[:id]

    return if @post
    flash[:danger] = "Post doesn't exist!"
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit :content
  end
end
