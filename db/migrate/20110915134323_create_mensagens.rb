class CreateMensagens < ActiveRecord::Migration
  def self.up
    create_table :mensagens do |t|
      t.text :conteudo
      t.integer :usuario_id
      t.integer :turma_id
      t.boolean :resposta
      t.integer :resposta_para_mensagem_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mensagens
  end
end
