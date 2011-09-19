class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_authentication
    if not authenticated?
      redirect_to :controller => 'authentications', :action => 'create'
    end
  end

  def authenticated?
    session[:user_token]
  end

  rescue_from Koala::Facebook::APIError do |exception|
    redirect_to(:controller  => :authentications,
                :action      => :create,
                :redirect_to => params[:redirect_to])
  end

end
