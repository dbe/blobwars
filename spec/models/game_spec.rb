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

require 'spec_helper'

describe Game do
  pending "add some examples to (or delete) #{__FILE__}"
end

