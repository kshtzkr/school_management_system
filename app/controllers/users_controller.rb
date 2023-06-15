class UsersController < ApplicationController
  before_action :set_user, only: [:assign_role, :remove_role]
  before_action :authenticate_user!

  def new
    @student = UserBatch.new
  end

  def create
    @user = user.new(user_params)
    student_role = Role.find_or_create_by(name: 'student')

    respond_to do |format|
      if @user.save!
        @user.user_roles.create(role_id: student_role.id)
        format.html { redirect_to '/batches', notice: "Student was successfully linked." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    sign_out(current_user)
    redirect_to root_path, notice: "Signed out successfully."
  end

  def assign_role
    @user.roles << Role.find(params[:role_id])
    redirect_to @user, notice: 'Role assigned successfully.'
  end

  def remove_role
    @user.roles.delete(Role.find(params[:role_id]))
    redirect_to @user, notice: 'Role removed successfully.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
