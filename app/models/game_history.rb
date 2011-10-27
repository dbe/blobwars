class GameHistory < ActiveRecord::Base
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

