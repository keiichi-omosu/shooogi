# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

# 盤面を出力する、入力するクラス
class GameScreen
  BLANK_PIECE = ' '

  class << self
    def print_player_pieces(player)
      puts "#{player}:#{player.pieces.map(&:label).join(' ')}" # これ一撃copilot
    end

    def print_board(board)
      print_board_header
      Board::LINE.size.times do |y|
        puts "#{y + 1} |" + Board::ROW.size.times.map { |x| piece_label(board.piece_at(x, y)) }.join('|')
      end
    end

    def print_win_message(turn)
      p "#{turn.current}の勝ちです"
    end

    def input_move(turn)
      puts "#{turn.current}: 入力してください"
      gets.chomp
    end

    private

    def print_board_header
      puts '  | A | B | C |'
    end

    def piece_label(piece)
      " #{piece&.label || BLANK_PIECE} "
    end
  end
end
