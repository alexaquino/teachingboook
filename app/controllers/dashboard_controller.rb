class DashboardController < ApplicationController
  require 'date'
  require 'usuario'
  
  before_filter :require_authentication, :only => :index

  helper_method :genders_total

  def index
    user    = api_client.get_object('me')
    usuario = login (user)
    
    @user_name = usuario.nome
    @minhas_turmas = usuario.turmas
    @minhas_disciplinas = usuario.disciplinas
  end

  private
  
  def login usuario
    if !usuario_existe?(usuario)
      new_user = Usuario.new({:fb_id => usuario['id'].to_i, :nome => usuario['name'], :data_nascimento => Date.strptime(usuario['birthday'], '%m/%d/%Y')})
      new_user.save
    end
    
    user_groups = api_client.get_object('me/groups')
    
    if user_groups
      cadastrar_grupos user_groups, usuario
    end
    
    Usuario.find_by_fb_id(usuario['id'])
    
  end
  
  def usuario_existe? usuario
    if Usuario.find_by_fb_id(usuario['id'].to_i)
      true
    else
      false
    end
  end
  
  def cadastrar_grupos grupos, usuario
    grupos.each do |g|
      if g['name'].include? '[TURMA]'
        if (!grupo_existe? g) && (g['administrator'])
          new_turma = Turma.new({:disciplina => g['name'].slice(8, g['name'].length), :group_id => g['id'], :professor_id => Usuario.find_by_fb_id(usuario['id']).id})
          new_turma.save
        end
        
        if (grupo_existe? g) && (!g['administrator'])
          turma = Turma.find_by_group_id(g['id'])
          user = Usuario.find_by_fb_id(usuario['id'])
          if !turma.alunos.member? user
            turma.alunos << user
          end
        end
      end
    end
  end
  
  def grupo_existe? grupo
    if Turma.find_by_group_id(grupo['id'])
      true
    else
      false
    end
  end

  def api_client
    Koala::Facebook::API.new(session[:user_token])
  end
end
