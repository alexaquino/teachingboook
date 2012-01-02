class Turma < ActiveRecord::Base
  
  belongs_to :usuario, :class_name => "Usuario", :foreign_key => "professor_id"
  has_and_belongs_to_many :usuarios, :join_table => "turmas_alunos"
  has_many :mensagens, :class_name => "Mensagem", :foreign_key => "mensagem_id"
  
end
