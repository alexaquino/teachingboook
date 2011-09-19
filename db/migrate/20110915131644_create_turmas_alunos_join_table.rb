class CreateTurmasAlunosJoinTable < ActiveRecord::Migration
  def self.up
    create_table :turmas_alunos, :id => false do |t|
      t.integer :turma_id
      t.integer :aluno_id
     end
  end

  def self.down
    drop_table :turmas_alunos
  end
end
