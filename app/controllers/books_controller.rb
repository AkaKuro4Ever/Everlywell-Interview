class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def new
    @book = Book.new(user_ids: params[:user_ids])
  end

  def create
    @book = Book.new(book_params)
    if @book.invalid?

      render :new
    else
      @book.save
      redirect_to book_path(@book)
    end
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  def edit
    @book = Book.find_by(id: params[:id])
  end

  def destroy
  end

  def follow
    @book = Book.find_by(id: params[:id])
    @book.followers << current_user
    redirect_to book_path(@book)
  end

  def unfollow
#    (Have to fix it so it doesn't constantly add people')
    @book = Book.find_by(id: params[:id])
    current_user.following.delete(Book.find(@book.id)) if current_user.following.where(id: @book.id)
    redirect_to book_path(@book)
  end

  private

  def book_params
    params.require(:book).permit(:id, :title, genre_ids: [], user_ids: [])
  end
end
