require 'test_helper'

class GameHistoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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

