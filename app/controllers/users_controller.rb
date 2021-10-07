class UsersController < ApplicationController
  def index
   @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page]).reverse_order

    #today_count = @user.books.where(created_at: Time.zone.now.all_day).count
    #@yesterday_count = @user.books.where(created_at: 1.day.ago.all_day).count

    #ex8bから改良
    @count_array = []
    @days_array = []

    for i in 0..6 do
      @count_array[i] = @user.books.where(created_at: i.day.ago.all_day).count
      @days_array[i] = (Time.zone.now-i.day).strftime("%-m/%-d")
    end

    #jsへ飛ばすよう
    gon.count_array = @count_array
    gon.days_array = @days_array

    if @count_array[1] == 0
      @perday = "NONE"
    else
      @perday = (@count_array[0]/@count_array[1].to_f)*100
    end

    @week_count = @user.books.where(created_at: (Time.zone.now.at_beginning_of_day-6.day)..Time.zone.now.at_end_of_day).count
    @lastweek_count = @user.books.where(created_at: (Time.zone.now.at_beginning_of_day-13.day)..(Time.zone.now.at_end_of_day-7.day)).count

    if @lastweek_count == 0
      @perweek = "NONE"
    else
      @perweek = (@week_count/@lastweek_count.to_f)*100
    end

    #binding.pry

  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      @books = current_user.books.page(params[:page]).reverse_order
      redirect_to user_path(current_user)
    end
  end

end
