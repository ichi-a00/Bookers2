class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.book_id = @book.id
    if @comment.save
      #redirect_to book_path(@book), notice: "You have created comment successfully."
    else
      #binding.pry
      #render 'error' #解説を見て真似してみる pretend 無限に増殖する
    end

  end

  def destroy
    #なにか個々に必要そう
    @book = Book.find(params[:book_id])
    Comment.find_by(id: params[:id]).destroy
    #redirect_to book_path(params[:book_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
