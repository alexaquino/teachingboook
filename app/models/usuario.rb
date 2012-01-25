class Usuario < ActiveRecord::Base

  has_and_belongs_to_many :disciplinas, :class_name => "Turma", :join_table => "alunos_turmas", :foreign_key => "aluno_id", :association_foreign_key => "turma_id"
  has_many :turmas, :foreign_key => "professor_id"
  has_many :mensagens
  has_many :questoes

end
