# frozen_string_literal: true

# 差し手を表すクラス
class Player
  attr_reader :pieces

  def initialize(label)
    @label = label
    @pieces = []
  end

  def to_s
    @label
  end
end
