# frozen_string_literal: true

# 駒を表すクラス
class Piece
  attr_reader :player

  def initialize(player)
    @player = player
  end

  def label
    # Todo 表示で分岐している。
    if @player.to_s == Turn::WHITE
      self.class::LABEL.downcase
    else
      self.class::LABEL
    end
  end

  def change_player(player)
    self.class.new(player)
  end

  def movable?(from_x, from_y, to_x, to_y)
    self.class.movable_positions(from_x, from_y).any? { |pos| pos[:x] == to_x && pos[:y] == to_y }
  end

  class << self
    private

    def movable_positions
      raise 'not implemented'
    end
  end
end

# ライオンさん
class LionPiece < Piece
  LABEL = 'L'

  class << self
    def movable_positions(from_x, from_y)
      [
        { x: from_x, y: from_y.next },
        { x: from_x, y: from_y.prev },
        { x: from_x + 1, y: from_y },
        { x: from_x + 1, y: from_y + 1 },
        { x: from_x + 1, y: from_y - 1 },
        { x: from_x - 1, y: from_y + 1 },
        { x: from_x - 1, y: from_y },
        { x: from_x - 1, y: from_y - 1 }
      ]
    end
  end
end

# キリンさん
class GiraffePiece < Piece
  LABEL = 'G'

  class << self
    def movable_positions(from_x, from_y)
      [
        { x: from_x, y: from_y + 1 },
        { x: from_x, y: from_y - 1 },
        { x: from_x + 1, y: from_y },
        { x: from_x - 1, y: from_y }
      ]
    end
  end
end

# ゾウさん
class ElephantPiece < Piece
  LABEL = 'E'

  class << self
    def movable_positions(from_x, from_y)
      [
        { x: from_x + 1, y: from_y + 1 },
        { x: from_x + 1, y: from_y - 1 },
        { x: from_x - 1, y: from_y + 1 },
        { x: from_x - 1, y: from_y - 1 }
      ]
    end
  end
end

# ひよこさん
class ChickPiece < Piece
  LABEL = 'C'

  class << self
    def movable_positions(from_x, from_y)
      [
        { x: from_x + 1, y: from_y + 1 },
        { x: from_x + 1, y: from_y - 1 },
        { x: from_x - 1, y: from_y + 1 },
        { x: from_x - 1, y: from_y - 1 }
      ]
    end
  end
end

# ニワトリさん
class ChickenPiece < Piece
  LABEL = 'P'
end
