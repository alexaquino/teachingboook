class DashboardController < ApplicationController
  
  def index
    user = session[:current_user]
    @usuario = Usuario.find(user.id)
    
    #@friends = api_client.get_connections('me', 'friends')
    #f = @friends.last
    
    #count = 0
    #@friends.each do |a|
    #  count += 1
    #  puts a
      #api_client.put_wall_post('Testando envio de mensagens automáticas ' + a['name'], :target_id => a['id'])
      #if count == 3 then
      #  break
      #end
    #end
    #api_client.put_wall_post('Testando envio de mensagens automáticas ', :target_id => 100002436347544)
    #api_client.put_connections(100002436347544,'notifications',{:from => 'me', :to => 100002436347544, :title => 'teste'})
  end

end
