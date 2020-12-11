

class Node
  include Comparable
  attr_accessor :data, :left, :right
  def initialize(data = nil)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    # the other is always the other item you are comparing the node against
    value = other.class == Node ? other.data : other
    self.data <=> value
  end

  def return_data
    p data.to_i
  end
end


class Tree
  attr_accessor :root, :arr
  def initialize(array)
    @root = build_tree(array)
    @arr = []
  end

  def build_tree(array)
    return if array.empty?

    result = array.sort.uniq
    return Node.new(result[0]) if result.length <= 1
    # only 1 element

    middle = result.length / 2
    root = Node.new(result[middle])
    root.left = build_tree(result[0...middle])
    # bound just before middle
    root.right = build_tree(result[middle + 1..array.length-1])
    # this will never go out of bounds of the array
    return root
  end

  def error_check(array)
    array.length == 0 ? (return nil) : ""
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, node = @root)
    # default to topmost node
    return if node == value

    insert_left(value, node) if node > value
    #the node arg is so that the code can memorise which node we are at when the recursion is done
    insert_right(value, node) if node < value
    # helper methods
  end

  def insert_left(value, node)
    node.left ? insert(value, node.left) : node.left = Node.new(value)
    # if left does not exists, creat the node
  end

  def insert_right(value, node)
    node.right ? insert(value, node.right) : node.right = Node.new(value)
  end



  def delete(value, node = @root)
    
    return nil if node.nil? # nothing to delete

    if value < node.data #continue leftward
      node.left = delete(value, node.left)
    elsif value > node.data #continue rightward
      node.right = delete(value, node.right)
    else #meaning value = node.data
      if node.left.nil?
        # no left value, so right node 
        # other case, if right is ALSO nil, this returns nil 
        # severing the link through the recursion!
        temp = node.right
        return temp

      elsif node.right.nil?
        temp = node.left
        return temp
                      
      end
      temp = min_value_node(node.right)

      node.data = temp.data 
      #successor node data
      #remember we had never messed with the object, just its content
      node.right = delete(temp.data, node.right)
  
    end
  
    return node 
    #as in the original root node = @root
    #we had never messed with this reference itself!
  end

  def min_value_node(node)
    current = node
    current = current.left while current.left
    # go left while current.left remains true (i.e. not nil)
    return current
  end


  def inorder(node)
    current_node = node
    
    if node != nil
        inorder(current_node.left)
        print current_node.data
        inorder(current_node.right)
    end
  end

  def preorder(node)
    current_node = node
    
    if node != nil
        print current_node.data  
        inorder(current_node.left)
        inorder(current_node.right)
        #pre order visits left child node of PARENT first
    end
  end
  
  def postorder(node)
    current_node = node
    
    if node != nil
         
        inorder(current_node.left)
        inorder(current_node.right)
        print current_node.data #post order visits left lowest child node first
    end
  end

  def height(node)

    return -1 if node.nil?

    max_left = height(node.left)
    max_right = height(node.right)
    #which ever of the 2, pick higher and add 1
    [max_left, max_right].max + 1

  end


  def depth(value, root = @root, counter = 0)
    until root.data == value #until u reach the value
    
    if value < root.data 
      root = root.left 
      #keep going left so long as value lesser than root
      counter = counter + 1 
    elsif value > root.data 
      root = root.right
      counter = counter + 1
      #keep going right so long as value more than root
    end
      
    end
    puts counter

  end


  def balanced?(node = @root)
    right_subtree_count = height(node.right)
    left_subtree_count = height(node.left)

    (left_subtree_count - right_subtree_count).abs > 1 ? (return false) : (return true)
    
  end

  def rebalance(node)
    if balanced?(node)
      return
    else
      @arr = []
      inorder_array(node)

      build_tree(@arr)
      return 
    end
  
  end

  def inorder_array(node)
    current_node = node
    
    if node != nil
        inorder(current_node.left)
        @arr.push(current_node.data)
        inorder(current_node.right)
    end
    return @arr
  end
end



i = Tree.new([1,2,3,4,5,6,7])

p i










