class CreateQuestoes < ActiveRecord::Migration
  def self.up
    create_table :questoes do |t|
      t.text :pergunta
      t.integer :autor_id, :limit => 8
      t.integer :turma_id, :limit => 8
      t.string :post_id

      t.timestamps
    end
  end

  def self.down
    drop_table :questoes
  end
end
