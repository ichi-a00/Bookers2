class SearchesController < ApplicationController

  def search
    @keyword = params[:keyword]
    @table = params[:table]
    @match = params[:match]

    #binding.pry

    case @table
      when "user" then
        @users = User.search(@keyword, @match)
        #binding.pry
        render "users/index"
      when "book" then
        @books = Book.search(@keyword, @match)
        @book = Book.new
        render "books/index"
    end

  end

end
