class DashboardController < ApplicationController
  
  def index
    user = session[:current_user]
    @usuario = Usuario.find(user.id)
  end

end
