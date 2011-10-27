class CreateGameHistories < ActiveRecord::Migration
  def self.up
    create_table :game_histories do |t|
      t.text :move_history
      t.string :winner

      t.timestamps
    end
  end

  def self.down
    drop_table :game_histories
  end
end
