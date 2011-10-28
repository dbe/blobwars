#rails env!
require File.expand_path('../../config/environment.rb',  __FILE__)

GameManager.delete_all
GameHistory.delete_all

#generate a random game
GameManager.create(:game_runner_klass => "blobular", :game_clients => "human_player human_player").game_histories.create( 
:move_history => Array.new(30) do
  {'x' => rand(20), 'y' => rand(20), 'team' => rand(3)}
end,
:winners => [0])
