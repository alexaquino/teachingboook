class Mensagem < ActiveRecord::Base
  
  has_many :children, :class_name => "Mensagem", :foreign_key => "resposta_para_mensagem_id"
  belongs_to :father, :class_name => "Mensagem"
  belongs_to :usuario, :class_name => "Usuario", :foreign_key => "usuario_id"
  belongs_to :turma, :class_name => "Turma", :foreign_key => "turma_id"
  
end
