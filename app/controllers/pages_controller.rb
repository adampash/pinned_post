class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def welcome
    redirect_to dashboard_path(current_user.site) if user_signed_in?
  end
end
