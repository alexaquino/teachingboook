class AddColumnNotaToMensagem < ActiveRecord::Migration
  def self.up
    add_column :mensagens, :nota, :double
  end

  def self.down
    remove_column :mensagens, :nota
  end
end
