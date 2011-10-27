class GameRunner < ActiveRecord::Base
end

# == Schema Information
#
# Table name: game_runners
#
#  id                :integer         not null, primary key
#  game_runner_klass :string(255)
#  game_clients      :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

