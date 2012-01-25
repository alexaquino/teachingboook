class Questao < ActiveRecord::Base
  
  has_many :respostas, :class_name => "Mensagem", :as => :recebedor
  belongs_to :autor, :class_name => "Usuario", :foreign_key => "autor_id"
  belongs_to :turma
  
end
