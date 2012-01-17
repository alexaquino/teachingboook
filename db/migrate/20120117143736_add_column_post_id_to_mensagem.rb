class AddColumnPostIdToMensagem < ActiveRecord::Migration
  def self.up
    add_column :mensagens, :post_id, :string
  end

  def self.down
    remove_column :mensagens, :post_id
  end
end
