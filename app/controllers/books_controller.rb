class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    #...
  end

  def edit #他人のediitはできないように
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      flash[:alert] = '他人の本の編集画面には行けません'
      redirect_to books_path
    end
  end

  def update
    book = Book.find(params[:id])
    #binding.pry
    book.update(book_params)
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
