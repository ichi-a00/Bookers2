class UsersController < ApplicationController
  def index
   @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @currentRoomUser = RoomUser.where(user_id: current_user.id)  #current_userが既にルームに参加しているか判断
    @receiveUser = RoomUser.where(user_id: @user.id)  #他の@userがルームに参加しているか判断

    unless @user.id == current_user.id  #current_userと@userが一致していなければ
      @currentRoomUser.each do |cu|    #current_userが参加していルームを取り出す
        @receiveUser.each do |u|    #@userが参加しているルームを取り出す
          if cu.room_id == u.room_id    #current_userと@userのルームが同じか判断(既にルームが作られているか)
            @haveRoom = true    #falseの時(同じじゃない時)の条件を記述するために変数に代入
            @roomId = cu.room_id   #ルームが共通しているcurrent_userと@userに対して変数を指定
          end
        end
      end
      unless @haveroom    #ルームが同じじゃなければ
        #新しいインスタンスを生成
        @room = Room.new
        @RoomUser = RoomUser.new
        #//新しいインスタンスを生成
      end
    end

    @books = @user.books.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      @books = current_user.books.page(params[:page]).reverse_order
      redirect_to user_path(current_user)
    end
  end
end
