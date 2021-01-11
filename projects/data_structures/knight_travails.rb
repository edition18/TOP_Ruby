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
      add_queue(current, queue)
    end
  end


      
  def add_queue(current, queue)
      # current is a Knight object
      current.possible_moves.each do |move|
      # see that for the current location, you execute possible moves
      # each possible move is a Knight object with a move coordinate
      queue << move
      # also, queue it to attempt a path
      # meaning, whatever u put to queue is a new Current coord
      # meaning, you queue multiple possible moves FOLLOWING your first move from where you are at
      move.node_prior_to_destination = current
      # in the .node_prior_to_destination you are saving another Knight Object with its current location (i.e before this current move)
    end
  end

  def knight_moves(start, target)
    last_node = bfs(start, target)
    # bfs returns the last node visited
    return if last_node.nil?

    path = retrieve_parent_nodes(last_node)
    print_path(path)
  end

  def retrieve_parent_nodes(last_node)
    path = [last_node]
    until last_node.node_prior_to_destination.nil?
      #keep going until node to prior is nil
      path.unshift(last_node.node_prior_to_destination)
      # unshift is to add the node prior to front of queue
      last_node = last_node.node_prior_to_destination
      # continue going down the historical nodes went into
    end
    return path
  end

  def print_path(path)
    puts "You made it in #{path.length - 1} moves! Here's your path:"
    path.each { |knight_object| p knight_object.coord }
  end

end







x = Board.new
x.knight_moves([3, 3], [4, 3])