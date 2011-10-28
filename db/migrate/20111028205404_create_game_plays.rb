class CreateGamePlays < ActiveRecord::Migration
  def self.up
    create_table :game_plays do |t|
      t.references :ai
      t.references :game
      t.boolean :winner

      t.timestamps
    end
  end

  def self.down
    drop_table :game_plays
  end
end
