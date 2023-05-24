class AdminController < ApplicationController
before_action :require_admin
  def dashboard
    @users = User.all.where(role: 0)
  end
  
  private
    def require_admin
      render file: "/public/404" unless current_admin?
    end

    def current_admin?
      current_user && current_user.admin?
    end
end