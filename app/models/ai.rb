# == Schema Information
#
# Table name: ais
#
#  id         :integer         not null, primary key
#  logic      :text
#  player_id  :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Ai < ActiveRecord::Base
  belongs_to :player
  has_many :game_plays
  has_many :games, :through => :game_plays
  
  def wins
    games_plays.where(:winner => true).map{|x| x.game}
  end
  
  def losses
    games - wins
  end
  
  def stats
    wins.size.to_f / games.size
  end
end

