class CommentsController < ApplicationController
  # allow only authenticated users to delete comments
  http_basic_authenticate_with name: "rails_user", password: "secretpassword", only: :destroy

# standard CRUD actions in each controller in the following order: index, show, new, edit, create, update and destroy
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
