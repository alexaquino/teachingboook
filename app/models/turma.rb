class Turma < ActiveRecord::Base
  
  has_and_belongs_to_many :alunos, :class_name => "Usuario", :join_table => "alunos_turmas", :foreign_key => "turma_id", :association_foreign_key => "aluno_id"
  belongs_to :professor, :class_name => "Usuario", :foreign_key => "professor_id"
  has_many :questoes
  
end
