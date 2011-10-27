class CreateGameManagers < ActiveRecord::Migration
  def self.up
    create_table :game_managers do |t|
      t.string :game_runner_klass
      t.string :game_clients
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :game_managers
  end
end
