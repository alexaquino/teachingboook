class CreateAlunosTurmasJoinTable < ActiveRecord::Migration
  def self.up
    create_table :alunos_turmas, :id => false do |t|
      t.integer :aluno_id
      t.integer :turma_id
     end
     
     add_index(:alunos_turmas, [:aluno_id, :turma_id], :unique => true)
     
  end

  def self.down
    drop_table :alunos_turmas
  end
end
