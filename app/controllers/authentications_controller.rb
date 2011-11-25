class AuthenticationsController < ApplicationController
  before_filter :authentication_check, :only => :canvas

  def create
    get_authorization_parameters
  end

  def canvas
    get_authorization_parameters
  end

  def auth
    session[:user_token] = user_token
    redirect_to_home
  end

  private

  def get_authorization_parameters
    @client_id    = FACEBOOK[:APP_ID]

    case action_name
    when 'create'
      @redirect_uri = FACEBOOK[:CALLBACK_URL][:SITE]
    when 'canvas'
      @redirect_uri = FACEBOOK[:CALLBACK_URL][:CANVAS]
    end
  end

  def user_token
    if params.include? :signed_request
      oauth.parse_signed_request(params[:signed_request])
    else
      oauth.get_access_token(params[:code])
    end
  end

  def oauth
    Koala::Facebook::OAuth.new(FACEBOOK[:APP_ID], FACEBOOK[:APP_SECRET], callback_url)
  end

  def callback_url
    if redirect_to_canvas?
      FACEBOOK[:CALLBACK_URL][:CANVAS]
    else
      FACEBOOK[:CALLBACK_URL][:SITE]
    end
  end

  def redirect_to_canvas?
    params.include?(:redirect_to) && params[:redirect_to] == 'canvas_page'
  end

  def redirect_to_home
    if redirect_to_canvas?
      return redirect_to FACEBOOK[:CANVAS_PAGE]
    else
      return redirect_to root_path
    end
  end

  def authentication_check
    if user_has_oauth_token?
      redirect_to root_path
    end
  end

  def user_has_oauth_token?
    if user_token.class == Hash && user_token.include?('oauth_token')
      session[:user_token] = user_token['oauth_token']
      return true
    else
      return false
    end
  end
end