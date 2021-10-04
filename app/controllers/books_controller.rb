class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    #過去一週間以内にふぁぼられた順
    @to = Time.current.at_end_of_day
    @from = (@to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorites).sort {|a,b|
      b.favorites.includes(:favorites).where(created_at: @from...@to).size <=>
      a.favorites.includes(:favorites).where(created_at: @from...@to).size
    }
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    # ...
    @comment = Comment.new
  end

  def edit # 他人のediitはできないように
    # @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      flash[:alert] = 'error! 他人の本の編集ページには行けません'
      redirect_to books_path
    end
  end

  def update
    # @book = Book.find(params[:id])
    # binding.pry
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    # book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, alert: "You have destroyed book successfully:)"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
