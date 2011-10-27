class GameHistory < ActiveRecord::Base
  serialize :move_history
  belongs_to :game_runner
  validate :game_runner, :presence => true
  
  def jsonify
    {
      'dimensions' => game_runner.dimensions,
      'deltas' => move_history
    }.to_json
  end
end

# == Schema Information
#
# Table name: game_histories
#
#  id           :integer         not null, primary key
#  move_history :text
#  winner       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

