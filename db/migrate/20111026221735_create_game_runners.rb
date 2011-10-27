class CreateGameRunners < ActiveRecord::Migration
  def self.up
    create_table :game_runners do |t|
      t.string :game_runner_klass
      t.string :game_clients

      t.timestamps
    end
  end

  def self.down
    drop_table :game_runners
  end
end
