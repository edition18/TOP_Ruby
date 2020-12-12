POSSIBLE_MOVES = [[1, 2], [2, 1], [-1, 2], [-2, 1], # upward moves
      [1, -2], [2, -1], [-1, -2], [-2, -1] # downward moves
].freeze

class Board
  

end


class Knight
  attr_accessor :coord, :adjacent_nodes
  def initialize(x,y)
    @coord = [x,y]
    @adjacent_nodes = []
  end


  def possible_moves(current_coord = @coord, possible_coord = @adjacent_nodes)
    POSSIBLE_MOVES.each do |move|
      # since each move is a coord array of [x,y]
      # similiar to coord
      # https://www.geeksforgeeks.org/ruby-array-zip-function/
      # if you zip it , it simply brings the 2 elements of interest and merges them into an array
      # [1,2].zip([3,4]) = > [[1,3],[2,4]]
      # when u .map , you take each of the elements (i.e. pairs of zip)
      # putting bounds between 0 - 7 means it will stay in bounds
      new_coord = move.zip(current_coord).map{ |x, y| x + y if (x + y).between?(0, 7) }
      possible_coord.push(new_coord)
    end
    return possible_coord
  end
end

p = Knight.new(3,5)
p p.possible_moves