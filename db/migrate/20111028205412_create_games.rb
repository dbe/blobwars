class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.text :move_history
      t.string :game_runner_klass
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
