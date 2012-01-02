class DashboardController < ApplicationController
  require 'date'
  require 'usuario'
  
  before_filter :require_authentication, :only => :index

  helper_method :genders_total

  def index
    user    = api_client.get_object('me')
    login (user)
    @user_first_name = user['first_name']
    @user_gender = user['gender']

    friends        = api_client.get_connections('me', 'friends')
    @friends_total = friends.count

    friend_ids = friends.collect { |friend| friend['id'] }
    @genders   = Array.new
    
    friend_genders = api_client.get_objects(friend_ids, {:fields => 'gender'})
    
    friend_genders.each do |f|
      @genders << f[1]['gender']
    end
    
    @males   = @genders.count{ |friend| friend == 'male'}
    @females = (genders_total - @males).to_i
  end

  private
  
  def login usuario
    if usuario_existe?(usuario)
      return
    end
    
    new_user = Usuario.new({:fb_id => usuario['id'].to_i, :nome => usuario['name'], :data_nascimento => Date.strptime(usuario['birthday'], '%m/%d/%Y')})
    new_user.save
  end
  
  def usuario_existe? usuario
    puts '********************************' + usuario['id']
    if Usuario.find_by_fb_id(usuario['id'].to_i)
      true
    else
      false
    end
  end

  def genders_total
    @genders.size.to_f
  end

  def api_client
    Koala::Facebook::API.new(session[:user_token])
  end
end
