class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :vote]
  before_action :correct_user, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by {|post| post.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post has been created."
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "This post has been updated."
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def vote
    @vote = Vote.create(creator: current_user, vote: params[:vote], voteable: @post)

    respond_to do |format|
      format.js
      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote has been accepted."
        else
          flash[:error] = "You have already voted on this post."
        end
        redirect_to :back
      end
    end
  end

  private

  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find_by(slug: params[:id])
  end

  def correct_user
    if current_user != @post.creator
      flash[:error] = "You're not allowed to do that."
      redirect_to root_path
    end
  end
end
