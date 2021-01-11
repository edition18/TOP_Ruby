class Graph
  attr_accessor :vertices,:edges,:adj_list,:marked,:edge_to
  def initialize(v)
    @vertices = v
    @edges = 0
    @adj_list = []
    @marked = []
    adj_list_generator
  end

  def adj_list_generator
    i = 0

    while i < @vertices 
      @adj_list[i] = Array.new
      @marked[i] = false # a vertice is just a node , such as 0 , 1 , 2
      i = i + 1
    end
    
  end

  def add_edge(a,b)
    @adj_list[a].include?(b) ? "" : (@adj_list[a].push(b))
    @adj_list[b].include?(a) ? "" : (@adj_list[b].push(a))
  end

  def add_vertice
    @vertices = @vertices + 1
  end


  def show_graph
    i = 0
   
    # for every subarray in adj_list
    while i < @vertices
      puts "#{i} ->  "
      j = 0
      while j < @vertices
        @adj_list[i][j].nil? ? "" : (puts "#{@adj_list[i][j]}") 
        j =  j + 1
      end
      i = i + 1
    end
  end

  def bfs(v)
    queue = []
    @marked[v] = true
    
    queue.push(v);
    while queue.length > 0
      current = queue.shift
      if current != nil
        print " visited #{current}"
      end
      i = 0
      while i < @adj_list[current].length
        neighbour = @adj_list[current][i]
        if !@marked[neighbour]
          @marked[neighbour] = true
          # you never attempt to visit a vertice twice
          queue.push(neighbour)
          # push the neighbour on queue
        end
        i = i + 1
      end
    end

  end

  def shortest(v, target)
    queue = []
    @marked[v] = true
    
    queue.push(v);
    while queue.length > 0
      current = queue.shift
      if current != nil
        print " visited #{current}"
      end
      i = 0
      while i < @adj_list[current].length
        neighbour = @adj_list[current][i]
        if !@marked[neighbour]
          @marked[neighbour] = true
          # you never attempt to visit a vertice twice
          queue.push(neighbour)
          # push the neighbour on queue
        end
        i = i + 1
      end
    end


  end
  




end

g = Graph.new(10)
g.add_edge(0,1)
g.add_edge(0,2)
g.add_edge(1,3)
g.add_edge(2,4)
# i added the below
g.add_edge(4,5)
g.add_edge(5,2)
g.add_edge(6,7)
g.add_edge(1,7)
# i added the above
g.show_graph
# g.bfs(0)
g.shortest(0,7)