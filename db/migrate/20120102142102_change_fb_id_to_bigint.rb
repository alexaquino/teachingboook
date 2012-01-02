class ChangeFbIdToBigint < ActiveRecord::Migration
  def self.up
    change_column :usuarios, :fb_id, :bigint
  end

  def self.down
    change_column :usuarios, :fb_id, :integer
  end
end