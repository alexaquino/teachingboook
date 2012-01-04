class AddColumnGroupIdToTurma < ActiveRecord::Migration
  def self.up
    add_column :turmas, :group_id, :bigint 
  end

  def self.down
    remove_column :turmas, :group_id
  end
end
