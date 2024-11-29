class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :reply]

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @product, notice: "Коментар успішно додано."
    else
      redirect_to @product, alert: "Не вдалося додати коментар."
    end
  end

  def reply
    @parent_comment = Comment.find(params[:comment_id])
    @reply = @parent_comment.replies.new(comment_params)
    @reply.user = current_user  # Прив'язуємо поточного користувача до відповіді
    @reply.product = @parent_comment.product

    if @reply.save
      redirect_to @parent_comment.product, notice: "Відповідь успішно додана!"
    else
      redirect_to @parent_comment.product, alert: "Не вдалося додати відповідь!"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)  # Параметри для коментаря
  end
end






