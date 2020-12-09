

class Node
  include Comparable
  attr_accessor :data, :left, :right
  def initialize(data)
    @data = nil
    @left = nil
    @right = nil
  end

  def <=>(other)
    value = other.class == Node ? other.data : other
    self.data <=> value
  end

  def return_data
    p data.to_i
  end
end


class Tree
  attr_accessor :root
  def initialize(array)
    @root = build_tree(array)
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
    root
  end

  def error_check(array)
    array.length == 0 ? (return nil) : ""
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end


  def insert(value)
    tree_node = @root
    until tree_node == nil
      if value > tree_node
        #go right
        tree_node = tree_node.right
      elsif value < tree_node
        #go left
        tree_node = tree_node.left
      else
        print "node already exists"
        return # equal to tree node, ignore
      end
    end
    tree_node = Node.new(value)
  end

    
end

i = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
i.insert(200)
i.pretty_print




