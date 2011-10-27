class GameHistory < ActiveRecord::Base
  serialize :move_history
  belongs_to :game_manager
  validate :game_manager, :presence => true
  
  def jsonify
    {
      'dimensions' => game_manager.dimensions,
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

