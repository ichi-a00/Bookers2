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
    @user = @book.user

    #@room_id = search_room_id(@user)

#
#    unless @user.id == current_user.id  #current_userと@userが一致していなければ
#      currentRoomUser = RoomUser.where(user_id: current_user.id)  #current_userが既にルームに参加しているか判断
#      receiveUser = RoomUser.where(user_id: @user.id)  #他の@userがルームに参加しているか判断
#
#      currentRoomUser.each do |cu|    #current_userが参加していルームを取り出す
#        receiveUser.each do |u|    #@userが参加しているルームを取り出す
#          if cu.room_id == u.room_id    #current_userと@userのルームが同じか判断(既にルームが作られているか)
#            @haveroom = true    #falseの時(同じじゃない時)の条件を記述するために変数に代入
#            @room_id = cu.room_id   #ルームが共通しているcurrent_userと@userに対して変数を指定
#          end
#        end
#      end
#    end
#    unless @haveroom    #ルームが同じじゃなければ
#        #新しいインスタンスを生成
#        @room = Room.new
#        @RoomUser = RoomUser.new
#        #//新しいインスタンスを生成
#    end

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
