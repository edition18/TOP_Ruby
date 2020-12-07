def fibs(n) 
  #iterative version of fibonacci sequence
  # n being nth term of the sequence
  sum = 0    
  return sum = n if ( (n == 0) || (n == 1))
  # if n = 1 or lower, there is no sequence
  x = 0  # F [n - 2]
  y = 1  # F [n - 1]
    
  i = 2 
  # anything below or equal to 2 doesnt add consistently
  while i <= n do 
    sum = x + y 
    x = y #change to the next biggest term for the next iteration
    y = sum # update to the value of new biggest term
    
    i += 1 # iterate
  end
  return sum
end


p fibs(3) 

def fibs_rec(n)
  #recursive version of fibonacci sequence
  n < 2 ? (return n) : (return (fibs_rec(n-1) + fibs_rec(n-2)))

  #if n is lesser than 2, it means that the sequence return itself per fibonacci table
  # https://www.mathsisfun.com/numbers/fibonacci-sequence.html

  # if not then the current value will always be the make up of n-1 term and the n-2 term
end

p fibs_rec(3) 