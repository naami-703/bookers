class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "Book was successfully update"
     redirect_to book_path(@book.id)
    else
      flash[:error] = @book.errors.full_messages.join(",")
      @error_count = @book.errors.count
      render :edit
  end
end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created"
      redirect_to book_path(@book.id)
    else
      flash.now[:error] = @book.errors.full_messages.join(",")
      @error_count = @book.errors.count
      @books = Book.all
      render :index
     end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
