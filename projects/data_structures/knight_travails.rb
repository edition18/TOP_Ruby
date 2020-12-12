POSSIBLE_MOVES = [[1, 2], [2, 1], [-1, 2], [-2, 1], # upward moves
      [1, -2], [2, -1], [-1, -2], [-2, -1] # downward moves
].freeze




class Knight
  attr_accessor :coord, :adjacent_nodes, :node_prior_to_destination
  def initialize(x,y)
    @coord = [x,y]
    @adjacent_nodes = [] # looking for possible moves in relation to current coord
    @node_prior_to_destination = nil
  end


  def possible_moves(current_coord = @coord, possible_coord = @adjacent_nodes)
    POSSIBLE_MOVES.each do |move|
      # since each move is a coord array of [x,y]
      # https://www.geeksforgeeks.org/ruby-array-zip-function/
      # if you zip it , it simply brings the 2 elements of interest and merges them into an array
      # [1,2].zip([3,4]) = > [[1,3],[2,4]]
      # when u .map , you take each of the elements (i.e. pairs of zip)
      # putting bounds between 0 - 7 means it will remain a legal move
      new_coord = move.zip(current_coord).map{ |x, y| x + y if (x + y).between?(0, 7) }
      possible_coord.push(new_coord)
    end
    return possible_coord
    # the idea is to generate ALL possible moves we could go to from the current spot
  end
end

class Board
  def bfs(start,target)
    knight = Knight.new(start)
    # your starting point is already found, so enqueue it first

    discovered = [knight]
    #start to build the discovered list
    # [2,1] [2,2] [3,2]
    queue = [knight]
    # start to build the queue
    until queue.empty?
      current = queue.shift
      # continuing queuing until u find a solution to the target
      # since this is a QUEUE, its FIFO
      return current if current.coord == target

      add_to_discovered_and_queue(current, discovered, queue)
    end
  end


      
  def add_to_discovered_and_queue(current, discovered, queue)
    # for each possible_moves left
    # check if discovered already has it
    # if not, bring it to discovered list
    # also, queue it
    
    current.possible_moves.each do |move|
      # see that on every each, possible_moves executes
      # i.e. you generate a set of moves for the current location
      
      next if discovered.include?(move)
      # if that move is already discovered, go next
      # i.e. you've already went there
      # you cannot go repeat a route you've already tried
      
      discovered << move
      # if not, add to discovered
      # its a unique route
      queue << move
      # also, queue it to attempt a path
      # meaning, whatever u put to queue is a new Current coord
      # meaning, you queue multiple moves FOLLOWING your first move from where you are at
      move.node_prior_to_destination = current
      # stores the last node that u travelled to
    end
  end

end







p = Knight.new(3,5)
p p.possible_moves