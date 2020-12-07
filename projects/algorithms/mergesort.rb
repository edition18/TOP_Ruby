def merge_sort(array)
  p array.length
  if array.length < 2
    # no need to mergesort
    # if array only length 1 or 0
    return array 
  else
    # it doesnt matter array.length is actually more than the size of the array, ruby automatically takes it to the maximum length of the array at this current point
    # in my case I just refactored it to the right dimensions

    # array.length / 2 always rounds down
    # for instance, a length of 7 divides to 3 = array.length / 2
    # since both left and right uses array.length / 2 , this would have been an issue
    # since we always going down to the BASE CASE, i.e 1, the rounding error is NOT to be an issue

    left = merge_sort(array[0...array.length / 2])
    p left
    right = merge_sort(array[array.length / 2...array.length])
    p right
    merge(left, right)
  end
end


def merge(left,right)
  # by default, we have set the order to be ascending
  array = []
  (left.length + right.length).times do
    if left.empty?
      item = right.shift 
      #takes out the leftmost/smallest item in array
      #also modifies array
      array.push(item)
    elsif right.empty?
      item = left.shift
      array.push(item)
    else
      comparison = left <=> right 
      # this always compare first item of the respective arrays!
        # if x < y then return -1
        # if x =y then return 0
        # if x > y then return 1
        # if x and y are not comparable then return nil
        if comparison == -1 # left < right
          item = left.shift
          array.push(item)
        elsif comparison == 1 # left > right
          item = right.shift
          array.push(item)
        else 
          #doesn't matter which gets push 
          #choose left without consequence 
          item = left.shift
          array.push(item)
        end
      end
    end
    
    return array
  end

arr = []
rand(10).times do
  arr << rand(50)
end
array2 = [6,45,31,32,34,47,10]
print merge_sort(array2)


