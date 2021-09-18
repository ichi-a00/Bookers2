class RelationshipsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    follower = current_user.follower.new(book_id: book.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
  end
end
