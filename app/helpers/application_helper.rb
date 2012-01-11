module ApplicationHelper
  
  def mensagens recebedor
    mensagens = "<h3>Mensagens</h3>"
    mensagens << "<div id='mensagens'>"
    if recebedor.mensagens.any?
      mensagens << render(:partial => "mensagens/mensagem", :collection => recebedor.mensagens)
    end
    mensagens << "</div>"
    raw mensagens
  end
  
  def nova_mensagem recebedor
    raw render(:partial => "mensagens/nova_mensagem", :locals => { :recebedor => recebedor })
  end
  
end
