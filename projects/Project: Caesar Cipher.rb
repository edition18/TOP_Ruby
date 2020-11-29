
def caesar_cipher(string, shift)
  # the alphabet in ASCII starts with 97 for lower case a
  # the last alphabet lower case z is 122
  # the uppercase equivalent is + 32

  p array = string.chars.map{|x| x.ord}
  #map all to ASCII equivalent
  i = 0
  while i < array.length do 
    p array[i]
    # if array[i] is lowercase
    if array[i] >= 65 && array[i] <= 122
      array[i] = array[i] + shift
    p array[i]
    end
    i = i + 1    
  end

  result = array.map{|c| c.chr}.join('')
  puts result
end

caesar_cipher("Hello!!!!!!", 3)