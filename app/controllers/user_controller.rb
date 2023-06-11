class UserController < ApplicationController
  before_action :set_user, only: [:assign_role, :remove_role]
  before_action :authenticate_user!

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
end
