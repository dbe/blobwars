class GameManager < ActiveRecord::Base
  has_many :game_histories
  def dimensions
    {'x' => width, 'y' => height}
  end
  
  def game_runner
    load "runner/#{self.game_runner_klass}.rb"
    Object.const_get(self.game_runner_klass.classify).new
  end
  
  def clients
    i = 1
    clients = self.game_clients.split.map do |c|
      # Lets reload each AI class for each run.
      load "ai/#{c}.rb"
      #create the AI instance with a new id
      Object.const_get(c.classify).new(i += 1)
    end
  end
  def play
    history = game_runner.play(clients, self.width, self.height)
    self.game_histories.create(:move_history => history[:deltas].map do |delta|
      {'x' => delta.x, 'y' => delta.y, 'team' => delta.team}
    end, :winner => history[:winner])
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

