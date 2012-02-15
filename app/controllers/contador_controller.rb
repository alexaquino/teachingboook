class ContadorController < ApplicationController

  helper :send_doc
  include SendDocHelper
  
  def usuario_list
    @usuarios = Usuario.find(:all)
  end
  
  def usuario_report
    @usuarios = Usuario.find(:all)
    send_doc(
      render_to_string(:template => 'contador/usuario_list', :layout => false),
      '/usuario_list_result/invoice_usuarios/usuario', 
      'rails',
      'UsuarioReport', 
      'pdf')
  end

end
