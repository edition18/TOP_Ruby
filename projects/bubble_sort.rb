def bubble_sort(array)
    i = 0
    while i < array.length do
    k = 0
      
      while k < array.length - 1  do
        if array[k] < array[k + 1] # current lesser than next
  
        else
          temp = array[k] 
          array[k] = array[k + 1]
          array[k + 1] = temp
        end
  
        # for every i, loop k times
      k = k + 1
      p array
      end
      i = i + 1
    end
    p array
  end
  
  
  
  
  
  bubble_sort([4,3,78,2,0,2])
  