class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.integer :fb_id, :limit => 8
      t.string :nome
      t.date :data_nascimento

      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
  end
end
