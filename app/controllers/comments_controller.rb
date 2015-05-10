class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(params.require(:comment).permit(:body))
    @comment.post_id = params[:post_id]
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(creator: current_user, vote: params[:vote], voteable: @comment)

    if !@vote.errors.any?
      flash[:notice] = "Your vote has been accepted."
      redirect_to :back
    else
      flash[:error] = "You have already voted on this comment."
      redirect_to :back
    end
  end
end