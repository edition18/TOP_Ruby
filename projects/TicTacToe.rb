WINSTATES = [[1,2,3],[4,5,6],[7,8,9],[1,5,9],[3,5,7],[1,4,7],[2,5,8],[3,6,9]]

class Game
  #initialize game assets
  def initialize(player1, player2)
    @board = Array.new(10)
    @players = [player1.new("P1","x",1), player2.new("P2","y",2)]
    @current_player_id = 0 
    #this will point to the current player in array
    puts "#{current_player} goes first"
    #start the game
  end

  def play
      # game is in a play state until winner is found
      loop do
      #current player makes turn
          print_board
          take_turn(@players[@current_player_id])
      #has the player won?
        if check_for_winner?(@players[@current_player_id])
          p "#{current_player} is the winner"
          return
        #is the board full?
        elsif board_full?
          p "It's a draw!"
          return
        end
      p "REACH"
      switch_player
      #if not, next player
    end
  end

  def check_for_winner?(player)
    WINSTATES.any? do |combination|
      combination.all? {|cell| @board[cell] == player.marker}
    end
  end

  def take_turn(player)
  # take turn by selecting an integer
    loop do
      print "\n" + "#{@current_player_id}'s turn"
      print "\n" +  "Select your #{@players[@current_player_id].marker} position"
      entry = gets.to_i
      # p entry

      # p open_cells.include?(entry)
      open_cells.include?(entry) ? (
        @board[entry] = @players[@current_player_id].marker
        p "#{player} selects #{@players[@current_player_id].marker} position #{entry}"; return
      ) : (puts "#{entry} position is not available")
    end
  end

  def open_cells
    return (1..9).select{|pos| @board[pos].nil?}
    
  end

  def board_full?
    open_cells.empty?
  end

  def switch_player

      @current_player_id = other_player_id
    
  end

  def other_player_id
    return 1-@current_player_id
    # this will either return 1 = 1 - 0 or 0 = 1 - 1
  end

  def print_board
    
    row_pos = [[1,2,3],[4,5,6],[7,8,9]]
    formatted = row_pos.map { |row| row.map {|item| (@board[item].nil? ? item : @board[item])}}

    format_col_sep = formatted.map{|r| r.join(" | ")}
    print format_row_sep = format_col_sep.join("\n"+ "----------" +"\n")
    # we use print to utilize "\n"

  end

  def current_player
  print @players[@current_player_id].name
  end

end

class Player
  attr_reader :marker,:num, :name
  def initialize(name, marker,num)
    @name = name
    @marker = marker
    @num = num
  end

  # not using below for now
  def to_s #converts a class object to a desired text representation
    "Player #{num}"
  
    # default behavior: In case of the objects belonging to the 
  # user-defined class, .to_s method prints the hexadecimal code 
  # associated with that instance.
  end
end

Game.new(Player,Player).play