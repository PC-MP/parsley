class My::Settings::LibrariesController < My::SettingsController
  before_action :set_library, only: %i[show edit update destroy]

  def index
    @libraries = policy_scope(Library)
  end

  def new
    @library = Library.new
  end

  def create
    @library = Library.new library_params.merge(owner: current_user, group: current_user.group)
    authorize @library
    @library.save!
    redirect_to action: :show, id: @library.id
  end

  def show
  end

  def edit
  end

  def update
    authorize library
    library.update!(library_params)
    authorize library
    redirect_to action: :index, notice: 'success' 
  end

  def destroy
    library.destroy!
    redirect_to action: :index
  end

  private

  def library_params
    params.require(:library).permit(:name)
  end

  def library_id
    params[:id]
  end

  def library
    @library ||= policy_scope(Library).find(library_id)
  end

  def set_library
    authorize library
  end
end
