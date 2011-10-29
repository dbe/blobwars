# == Schema Information
#
# Table name: game_plays
#
#  id         :integer         not null, primary key
#  ai_id      :integer
#  game_id    :integer
#  winner     :boolean
#  created_at :datetime
#  updated_at :datetime
#

class GamePlay < ActiveRecord::Base
  belongs_to :ai
  belongs_to :game
end

