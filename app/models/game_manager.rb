class GameManager < ActiveRecord::Base
  validate :width, :presence => true
  validate :height, :presence => true
  
  
  CLIENT_FOLDER = "ai"
  RUNNER_FOLDER = "runner"
  
  has_many :game_histories
  def dimensions
    {'x' => width, 'y' => height}
  end
  
  def game_runner
    load "#{RUNNER_FOLDER}/#{self.game_runner_klass}.rb"
    Object.const_get(self.game_runner_klass.classify).new
  end
  
  def clients
    i = -1
    clients = self.game_clients.split.map do |c|
      # Lets reload each AI class for each run.
      load "#{CLIENT_FOLDER}/#{c}.rb"
      #create the AI instance with a new id
      Object.const_get(c.classify).new(i += 1)
    end
  end
  
  def play
    game_history = game_runner.play(clients, self.width, self.height)
    #p game_history
    # self.game_histories.create(:move_history => history[:deltas].map do |delta|
    #      {'x' => delta.x, 'y' => delta.y, 'team' => delta.team}
    #  end, :winner => history[:winner])
    self.game_histories.create(:move_history => game_history[:turns].map do |turn|
      {'playerID' => turn.team, 'deltas' => turn.deltas.map do |delta|
        {'x' => delta.x, 'y' => delta.y, 'objectID' => delta.object_id}
      end}
    end,
    :winners => game_history[:winners])
  end
end

# == Schema Information
#
# Table name: game_managers
#
#  id                :integer         not null, primary key
#  game_runner_klass :string(255)
#  game_clients      :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

