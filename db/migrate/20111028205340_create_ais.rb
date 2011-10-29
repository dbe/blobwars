class CreateAis < ActiveRecord::Migration
  def self.up
    create_table :ais do |t|
      t.boolean :active, :default => false, :null => false
      t.text :logic
      t.references :player
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ais
  end
end
