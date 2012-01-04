class ChangeColumnProfessorIdToBigint < ActiveRecord::Migration
  def self.up
    change_column :turmas, :professor_id, :bigint
  end

  def self.down
    change_column :turmas, :professor_id, :integer
  end
end
