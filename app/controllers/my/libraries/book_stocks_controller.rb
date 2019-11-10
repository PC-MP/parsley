class My::Libraries::BookStocksController < My::LibrariesController
  def index
  end

  def new
    @book_stock = BookStock.new(library: library)
  end

  def create
    @book = Book.find_by(jan: book_stock_params[:jan_code])
    unless @book
      @book = Book.build_from_jancode(book_stock_params[:jan_code])
      @book.save!
    end

    @book_stock = BookStock.create_with(stock: book_stock_params[:stock])
                    .find_or_create_by!(library_id: library.id, book_id: @book.id)

    redirect_to my_library_path(id: library.id)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def library_id
    params[:library_id]
  end

  def book_stock_params
    params.require(:book_stock).permit(:stock, :jan_code)
  end
end
