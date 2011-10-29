# == Schema Information
#
# Table name: games
#
#  id                :integer         not null, primary key
#  move_history      :text
#  game_runner_klass :string(255)
#  width             :integer
#  height            :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Game < ActiveRecord::Base
  has_many :game_plays
  has_many :ais, :through => :game_plays
  
  validate :width, :presence => true
  validate :height, :presence => true
  serialize :move_history

  DEFAULT_WIDTH = 20;
  DEFAULT_HEIGHT = 20;
  DEFAULT_GAME_RUNNER = 'blobular'
  RUNNER_FOLDER = 'runner'
  AIS_PER_GAME = 4
  
  def dimensions
    {'x' => width, 'y' => height}
  end
  
  def self.trigger
    Ai.where(:active => true).all(:group => :player_id).tap do |active_ais|
      if active_ais.size == AIS_PER_GAME
        active_ais.each do |ai|
          ai.update_attribute(:active, false)
        end
        return Game.create({:ais => active_ais, 
          :game_runner_klass => DEFAULT_GAME_RUNNER, 
          :width => DEFAULT_WIDTH, 
          :height => DEFAULT_HEIGHT
        })
      else
      end
    end
    nil
  end
  
  # Call play once all associations have been set up
  before_create do
    load "#{RUNNER_FOLDER}/#{self.game_runner_klass}.rb"
    game_runner = Object.const_get(self.game_runner_klass.classify).new
    
    clients = ais.map do |ai|
      # create a blank object for this player.
      AiBase.new(ai.id).tap{|o| o.class_eval ai.logic }
    end
    self.move_history = game_runner.play(clients, self.width, self.height)
    game_plays.where(:ai_id => move_history[:winners]).each{|winner| winner.update_attribute(:winner => true)}
  end
  
  def winner
    game_play.where(:winner => true).ai
  end
  
  def jsonify
    move_history.to_json
  end
  
  # class GameManager < ActiveRecord::Base
  #     validate :width, :presence => true
  #     validate :height, :presence => true
  # 
  # 
  #     CLIENT_FOLDER = "ai"
  #     RUNNER_FOLDER = "runner"
  # 
  #     has_many :game_histories
  #     def dimensions
  #       {'x' => width, 'y' => height}
  #     end
  # 
  #     def game_runner
  #       load "#{RUNNER_FOLDER}/#{self.game_runner_klass}.rb"
  #       Object.const_get(self.game_runner_klass.classify).new
  #     end
  # 
  #     def clients
  #       i = -1
  #       clients = self.game_clients.split.map do |c|
  #         # Lets reload each AI class for each run.
  #         load "#{CLIENT_FOLDER}/#{c}.rb"
  #         #create the AI instance with a new id
  #         Object.const_get(c.classify).new(i += 1)
  #       end
  #     end
  # 
  #     def play
  #       game_history = game_runner.play(clients, self.width, self.height)
  #       p game_history
  #       # self.game_histories.create(:move_history => history[:deltas].map do |delta|
  #       #      {'x' => delta.x, 'y' => delta.y, 'team' => delta.team}
  #       #  end, :winner => history[:winner])
  #       self.game_histories.create(:move_history => game_history[:turns].map do |turn|
  #         {'playerID' => turn.team, 'deltas' => turn.deltas.map do |delta|
  #           {'x' => delta.x, 'y' => delta.y, 'objectID' => delta.object_id}
  #         end}
  #       end,
  #       :winners => game_history[:winners])
  #     end
  #   end
end

