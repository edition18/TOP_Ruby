POSSIBLE_MOVES = [[1, 2], [2, 1], [-1, 2], [-2, 1], # upward moves
      [1, -2], [2, -1], [-1, -2], [-2, -1] # downward moves
].freeze




class Knight
  attr_accessor :coord, :adjacent_nodes, :node_prior_to_destination
  def initialize(coord = nil, node_prior_to_destination = nil)
    @coord = coord
    @adjacent_nodes = [] # looking for possible moves in relation to current coord
    @node_prior_to_destination = node_prior_to_destination
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

      !new_coord.include?(nil) ? possible_coord.push(Knight.new(new_coord)) : ""
      
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
      # the very first move you are already checking if first move can reach the target
      # if not, then we will start moving into the second move
      # then we will look into the third move, then following
      add_to_discovered_and_queue(current, discovered, queue)
    end
  end


      
  def add_to_discovered_and_queue(current, discovered, queue)
      current.possible_moves.each do |move|
      # see that for the current location, you execute possible moves
      
      next if discovered.include?(move) 
      # for each of those move.. if discovered already go next
      # this is searching all possible nodes
      # our initial list of possible nodes is only from the perspective of first move on the first coord
      
      discovered << move
      # if not already found, add to discovered

      queue << move
      # also, queue it to attempt a path
      # meaning, whatever u put to queue is a new Current coord
      # meaning, you queue multiple moves FOLLOWING your first move from where you are at
      move.node_prior_to_destination = current
      # stores the last node that u travelled to
    end
  end

  def knight_moves(start, target)
    last_node = bfs(start, target)
    return if last_node.nil?

    path = retrieve_parent_nodes(last_node)
    print_path(path)
  end

  def retrieve_parent_nodes(last_node)
    path = [last_node]
    until last_node.node_prior_to_destination.nil?
      path.unshift(last_node.node_prior_to_destination)
      last_node = last_node.node_prior_to_destination
    end
    path
  end

  def print_path(path)
    puts "You made it in #{path.length - 1} moves! Here's your path:"
    path.each { |vertice| p vertice.coord }
  end

end







x = Board.new
x.knight_moves([3, 3], [4, 3])