# frozen_string_literal: true

require_relative 'lib/piece'
require_relative 'lib/mover'
require_relative 'lib/board'
require_relative 'lib/game_screen'
require_relative 'lib/turn'
require_relative 'lib/player'

class ShogiError < StandardError; end

black = Player.new(Turn::BLACK)
white = Player.new(Turn::WHITE)

turn = Turn.new(black, white)

board = Board.new
board.init_black_pieces(black)
board.init_white_pieces(white)

loop do
  GameScreen.print_player_pieces(white)
  GameScreen.print_board(board)
  GameScreen.print_player_pieces(black)

  move_input = GameScreen.input_move(turn)

  mover = MoveParser.parse(move_input)
  mover.call(board, turn.current)

  if mover.win?
    GameScreen.print_win_message(turn)
    break
  end

  turn.next
rescue ShogiError => e
  p e.message
end

p 'ゲーム終了'
