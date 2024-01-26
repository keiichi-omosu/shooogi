# frozen_string_literal: true

require_relative 'piece'

# 盤面を表すクラス
class Board
  ROW = %w[A B C].freeze
  LINE = %w[1 2 3 4].freeze

  attr_reader :board

  def initialize
    @board = LINE.size.times.map { ROW.size.times.map { nil } }
  end

  def init_black_pieces(black)
    @board[3][0] = ElephantPiece.new(black)
    @board[3][1] = LionPiece.new(black)
    @board[3][2] = GiraffePiece.new(black)
    @board[2][1] = ChickPiece.new(black)
  end

  def init_white_pieces(white)
    @board[0][0] = GiraffePiece.new(white)
    @board[0][1] = LionPiece.new(white)
    @board[0][2] = ElephantPiece.new(white)
    @board[1][1] = ChickPiece.new(white)
  end

  def get_piece(xlabel, ylabel)
    x = row2index(xlabel)
    y = line2index(ylabel)

    piece = @board[y][x]
    @board[y][x] = nil
    piece
  end

  def put_piece(xlabel, ylabel, piece)
    x = row2index(xlabel)
    y = line2index(ylabel)

    @board[y][x] = piece
  end

  def piece_at(point_x, point_y)
    @board[point_y][point_x]
  end

  private

  def row2index(xlabel)
    case xlabel
    when 'A'
      0
    when 'B'
      1
    when 'C'
      2
    else
      raise '不明な値です'
    end
  end

  def line2index(ylabel)
    ylabel.to_i - 1
  end
end
