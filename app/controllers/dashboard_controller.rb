class DashboardController < ApplicationController
  before_filter :require_authentication, :only => :index

  helper_method :genders_total

  def index
    user    = api_client.get_object('me')
    @user_first_name = user['first_name']

    friends        = api_client.get_connections('me', 'friends')
    @friends_total = friends.count

    friend_ids = friends.collect { |friend| friend['id'] }
    @genders   = api_client.rest_call('users.getinfo', {:uids => friend_ids, :fields => 'sex'})

    @males   = @genders.count{ |friend| friend['sex'] == 'male'}
    @females = (genders_total - @males).to_i
  end

  private

  def genders_total
    @genders.size.to_f
  end

  def api_client
    Koala::Facebook::API.new(session[:user_token])
  end
end
