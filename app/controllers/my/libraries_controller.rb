# frozen_string_literal: true

# My::LibrariesController
class My::LibrariesController < MyController

  # GET /my/libraries(.:format)
  def index
    @libraries = policy_scope(Library)
    return redirect_to new_my_settings_library_path if @libraries.empty?

    redirect_to action: :show, id: @libraries.first.id
  end

  # GET /my/libraries/:id(.:format)
  def show
    @libraries = policy_scope(Library)
    @library   = @libraries.includes(book_stocks: :book).find(library_id)
    authorize @library
  end

  private

  def library_id
    params[:id]
  end

  def library
    @library ||= policy_scope(Library).find(library_id)
  end
end
