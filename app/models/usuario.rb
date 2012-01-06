class Usuario < ActiveRecord::Base

  has_and_belongs_to_many :turmas, :join_table => "turmas_alunos", :foreign_key => "aluno_id"
  has_many :turmas, :foreign_key => "professor_id"
  has_many :mensagens
  
  def self.existe? usuario
    if Usuario.where(["fb_id = ?", usuario['id']])
      true
    else
      false
    end
  end

end
