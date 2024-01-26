# frozen_string_literal: true

## 手番を表すクラス
class Turn
  BLACK = '先手'
  WHITE = '後手'
  attr_reader :current

  def initialize(black, white)
    @black = black
    @white = white
    @current = @black
  end

  def next
    @current = @current == @white ? @black : @white
  end
end
