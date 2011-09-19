class CreateTurmas < ActiveRecord::Migration
  def self.up
    create_table :turmas do |t|
      t.string :disciplina

      t.timestamps
    end
  end

  def self.down
    drop_table :turmas
  end
end
