# frozen_string_literal: true

# My::UsersController
class My::UsersController < MyController
  before_action :set_user, only: %i[show update destroy]

  # GET /my/users
  def index
    respond_to do |format|
      format.html
      format.json { render json: UserDatatable.new(params, current_user: current_user) }
    end
  end

  # GET /my/users/:id
  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_user
    @user = policy_scope(User).find(params[:id])
  end

  def users_params
    params.require(:users).permit(:email, :username, :group_id, :password, :password_confirmation)
  end

end
