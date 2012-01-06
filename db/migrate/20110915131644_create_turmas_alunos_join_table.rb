class CreateTurmasAlunosJoinTable < ActiveRecord::Migration
  def self.up
    create_table :turmas_alunos, :id => false do |t|
      t.integer :turma_id
      t.integer :aluno_id
     end
     
     add_index(:turmas_alunos, [:turma_id, :aluno_id], :unique => true)
     
  end

  def self.down
    drop_table :turmas_alunos
  end
end
