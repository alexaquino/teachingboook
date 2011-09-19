class Usuario < ActiveRecord::Base

  has_and_belongs_to_many :turmas, :join_table => "turmas_alunos", :foreign_key => "turma_id"
  has_many :turmas, :class_name => "Turma", :foreign_key => "turma_id"
  has_many :mensagens, :class_name => "Mensagem", :foreign_key => "mensagem_id"

end
