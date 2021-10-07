class SearchesController < ApplicationController

  def search
    @keyword = params[:keyword]
    @table = params[:table]
    @match = params[:match]
    @user_id = params[:user_id]

    #binding.pry

    case @table
      when "user" then
        @users = User.search(@keyword, @match, @user_id)
        #binding.pry
        render "users/index"
      when "book" then
        @books = Book.search(@keyword, @match, @user_id)
        @book = Book.new
        render "books/index"
      when "day" then
        @count_book = Book.search(@keyword, @match, @user_id).count
        #render "books/test"
    end

  end

end
