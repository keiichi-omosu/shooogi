# frozen_string_literal: true

Move = Struct.new(:x, :y, :piece, keyword_init: true)

# 駒を動かす基底クラス
class Mover
  def initialize
    @win = false
  end

  def call
    raise 'not implemented'
  end

  def win?
    @win
  end

  private

  def get_piece(board, move, player)
    piece = board.get_piece(move.x, move.y)

    raise ShogiError, '指定された位置に駒が存在しません' unless piece
    raise ShogiError, '自分の駒ではありません' if piece.player != player
    # Todoラベルで比較したくない
    raise ShogiError, '指定された駒が存在しません' if piece.label != move.piece

    piece
  end

  def put_piece(board, move, player, my_piece)
    other_piece = board.get_piece(move.x, move.y)
    raise ShogiError, '自分の駒が存在しています' if other_piece && other_piece.player == player

    board.put_piece(move.x, move.y, my_piece)
    other_piece
  end
end

# 駒を動かす
class PieceMover < Mover
  def initialize(from, to)
    @from = from
    @to   = to
    super()
  end

  def call(board, player)
    my_piece = get_piece(board, @from, player)
    #raise ShogiError, '移動できないマスです' unless my_piece.movable?(@from.x.ord, @from.y.to_i, @to.x.ord, @to.y.to_i)

    other_piece = put_piece(board, @to, player, my_piece)

    @win = true if other_piece.is_a?(LionPiece)
    player.pieces << other_piece.change_player(player) if other_piece
  end
end

# 手駒から駒を動かす
class HandPieceMover < Mover
  def initialize(to)
    @to = to
    super()
  end

  def call(board, player)
    index = player.pieces.find_index { |piece| piece.label == @to.piece }
    piece = player.pieces.delete_at(index)

    raise ShogiError, '指定された駒が存在しません' if piece.label != @to.piece

    put_piece(board, @to, player, piece)
  end
end

# 手の入力をパースする
class MoveParser
  SEP = ','

  class << self
    def parse(input)
      moves = input.split(SEP)

      if moves.size == 1
        HandPieceMover.new(parse_move(moves[0]))
      elsif moves.size == 2
        PieceMover.new(parse_move(moves[0]), parse_move(moves[1]))
      else
        raise '入力フォーマットエラー'
      end
    end

    def parse_move(move_str)
      chars = move_str.chars
      raise '入力フォーマットエラー' if chars.size != 3

      Move.new(x: chars[0], y: chars[1], piece: chars[2])
    end
  end
end
