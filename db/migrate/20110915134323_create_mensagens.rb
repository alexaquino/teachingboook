class CreateMensagens < ActiveRecord::Migration
  def self.up
    create_table :mensagens do |t|
      t.text :conteudo
      t.integer :autor_id, :limit => 8
      t.integer :recebedor_id, :limit => 8
      t.string :recebedor_type

      t.timestamps
    end

    add_index :mensagens, :recebedor_type
    add_index :mensagens, :recebedor_id

    
  end

  def self.down
    drop_table :mensagens
  end
end
