class Board
  attr_accessor :board

  def initialize
    @board = Array.new(6) { Array.new(7, nil) }
  end

  def display_instructions
    introduction = <<~HEREDOC
      #{'Welcome to Connect Four!'.pink}

      #{'In order to win, a player must get four checkers in their color in a row. Whoever does it first is the winner.'.light_blue}
      #{'- The checkers fall straight down, occupying the lowest available space within the column.'.light_blue}
      #{'- There are three ways to get four checkers in a row in Connect Four: horizontally, vertically, and diagonally.'.light_blue}
      #{'- You want to choose each move carefully because your opponent will have a turn after you.'.light_blue}

    HEREDOC
    puts introduction
  end

  def display_board
    self.display_instructions
    checker = '●'
    @board.each do |arr|
      print '|'
      arr.each do |cell|
        case cell.to_s
        when '0'
          print " #{checker.blue} "
        when '1'
          print " #{checker.red} "
        else
          print ' ○ '
        end
      end
      print '|'
      print "\n"
    end
    puts '  1  2  3  4  5  6  7  '
  end

  def update_board(column, current_player_id)
    column = column.to_i - 1
    row = available_row(column)
    checker = current_player_id.even? ? '0' : '1'
    board[row][column] = checker
  end

  def available_row(column)
    row = 5
    row -= 1 until board[row][column].nil? || row == 0
    row
  end

  def column_full?(column)
    if !board[0][column].nil?
      # puts 'This column is already full!'.pink
      true
    else
      false
    end
  end
end
