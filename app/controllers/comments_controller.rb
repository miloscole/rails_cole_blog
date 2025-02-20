class CommentsController < ApplicationController
  before_action :require_logged_in_user, only: [ :create, :destroy ]
  before_action :require_admin, only: [ :destroy ]
  def create
    article = Article.find(params[:article_id])
    @comment = Comment.new(comment_params)
    article.comments.push @comment
    @comment.user = current_user

    if @comment.save
      notice
      redirect_to article
    else
      alert
      redirect_to article
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    article = @comment.article
    @comment.destroy
    notice
    redirect_to article
  end

  private

  def comment_params
    params.require(:comment).permit(:message, :parent_id)
  end
end
