class CreateMensagens < ActiveRecord::Migration
  def self.up
    create_table :mensagens do |t|
      t.text :conteudo
      t.integer :autor_id, :limit => 8
      t.integer :objeto_id, :limit => 8
      t.string :objeto_type

      t.timestamps
    end

    add_index :mensagens, :objeto_type
    add_index :mensagens, :objeto_id

    
  end

  def self.down
    drop_table :mensagens
  end
end
