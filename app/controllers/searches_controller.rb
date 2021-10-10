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
        @books = Book.search(@keyword, @match, @user_id).page(params[:page]).reverse_order
        @book = Book.new
        render "books/index"
      #ex9b
      when "day" then
        @count_book = Book.search(@keyword, @match, @user_id).count
        #render "books/test"
      #ex9d
      when "category" then
        @books = Book.search_category(@keyword, @match).page(params[:page]).reverse_order
        @book = Book.new
        render "books/index"
    end

  end

end
