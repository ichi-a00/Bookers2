class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

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
    @sort = params[:sort]
    @book = Book.new

    case @sort
    when "fav_weekly" then
      #1週間以内ふぁぼソートは結構重い。
      @to = Time.current.at_end_of_day
      @from = (@to - 6.day).at_beginning_of_day
      books = Book.includes(:favorites).sort {|a,b|
        b.favorites.includes(:favorites).where(created_at: @from...@to).size <=>
        a.favorites.includes(:favorites).where(created_at: @from...@to).size
      }
    when "rate" then
      #評価順
      books=Book.all.order("rate desc")
    else
      #デフォルトは新着順
      books=Book.all.order("created_at desc")
    end

    @books=Kaminari.paginate_array(books).page(params[:page]).per(10)

  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user

    #閲覧数
    impressionist(@book, nil, unique: [:ip_address])

    @comment = Comment.new
  end

  def edit
    # 他人のediitはできないように -> ensure~で判別
    #book = Book.find(params[:id])
    #if @book.user == current_user
    #  render "edit"
    #else
    #  flash[:alert] = 'error! 他人の本の編集ページには行けません'
    #  redirect_to books_path
    #end
  end

  def update
    #@book = Book.find(params[:id])
    # binding.pry
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    #book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, alert: "You have destroyed book successfully:)"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :rate)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      flash[:alert] = 'error! 他人の本は編集できません'
      redirect_to books_path
    end
  end

end
