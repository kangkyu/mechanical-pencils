class ApplicationController < ActionController::Base
  include Pagy::Backend

  def ensure_login
    redirect_to root_path unless signed_in?
  end

  def ensure_admin
    redirect_back unless signed_in? && current_user.admin?
  end

  def signed_in?
    current_user_id.present?
  end

  def current_user_id
    session[:user_id]
  end

  def current_user
    @current_user ||= User.find current_user_id
  end

  helper_method :signed_in?
  helper_method :current_user_id
  helper_method :current_user
end
