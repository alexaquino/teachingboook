class CreateTurmas < ActiveRecord::Migration
  def self.up
    create_table :turmas do |t|
      t.string :disciplina
      t.integer :professor_id, :limit => 8
      t.integer :group_id, :limit => 8

      t.timestamps
    end
  end

  def self.down
    drop_table :turmas
  end
end
