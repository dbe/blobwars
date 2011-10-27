class GameManager < ActiveRecord::Base
  has_many :game_histories
  def dimensions
    {'x' => width, 'y' => height}
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

