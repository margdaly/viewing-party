class AdminController < ApplicationController
before_action :require_admin
  def dashboard
    @users = User.all.where(role: 0)
  end

  def user_show
    @user = User.find(params[:id])
  end
  
  private
    def require_admin
      render file: Rails.root.join('public', '404.html') unless current_admin?
    end

    def current_admin?
      current_user && current_user.admin?
    end
end