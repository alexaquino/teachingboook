class AddProfessorColumnToTurma < ActiveRecord::Migration
  def self.up
    add_column :turmas, :professor_id, :integer 
  end

  def self.down
    remove_column :turmas, :professor_id
  end
end
