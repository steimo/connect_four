require_relative 'board'
require_relative 'colors'

class Game
  attr_accessor :board, :current_player_id

  def initialize
    @board = Board.new
    @current_player_id = 0
    @win = false
  end

  def play_game
    board.display_board
    turn_order until game_over?
  end

  def turn_order
    player_turn
    @current_player_id += 1
  end

  def player_turn
    loop do
      puts "#{@current_player_id.even? ? 'Player 1'.blue : 'Player 2'.red}'s turn, please enter the number of columns you want to drop"
      input = verify_input(player_input)
      system "clear"
      board.update_board(input, current_player_id) unless input.nil?
      board.display_board
      break if input

      puts 'Input error!'.pink.blink
    end
  end

  def verify_input(number)
    return number if number.match?(/^[1-7]$/) && !board.column_full?(number.to_i - 1)
  end

  def player_input
    puts 'Choose a digit between 1 and 7:'.light_blue
    gets.chomp
  end

  def game_over?
    state = four_in_a_row(board.board)
    if state == '0'
      puts 'Player 1 won!'.blue.blink
      @win = true
    elsif state == '1'
      puts 'Player 2 won!'.red.blink
      @win = true
    end
  end

  def four_in_a_row_by_row(arr)
    arr.each do |row|
      a = row.each_cons(4).find { |a| a.uniq.size == 1 && !a.first.nil? }
      return a.first unless a.nil?
    end
    nil
  end

  def diagonals(grid)
    (0..grid.size - 4).map do |i|
      (0..grid.size - 1 - i).map { |j| grid[i + j][j] }
    end.concat((1..grid.first.size - 4).map do |j|
      (0..grid.size - j).map { |i| grid[i][j + i] }
    end)
  end

  def rotate90(grid)
    ncols = grid.first.size 
    grid.first.each_index.with_object([]) do |i, a|
      a << 6.times.map { |j| grid[j][ncols - 1 - i] }
    end
  end

  def four_in_a_row(grid)
    four_in_a_row_by_row(grid) ||
      four_in_a_row_by_row(grid.transpose) ||
      four_in_a_row_by_row(diagonals(grid)) ||
      four_in_a_row_by_row(diagonals(rotate90(grid)))
  end
end

game = Game.new
game.play_game
