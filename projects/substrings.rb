# Implement a method #substrings that takes a word as the first argument
# and then an array of valid substrings (your dictionary) as the second argument
#  It should return a hash listing each substring (case insensitive) that was found in the original string and how many times it was found.

def substrings(string, dictionary)

    #convert all nonalphabets to black space
    array = string.chars.map{|x| x.ord}
    
  
    i = 0
    while i < array.length do
      if array[i] < 65 || array[i] > 122
        array[i] = 32
      end
      i = i + 1
    end
  
    lower = array.map{|c| c.chr}.join('').downcase.split(" ")
  
    hashDictionary = Hash.new
  
    dictionary.each do |word|
        hashDictionary[word] = 0
    end
  
  
    # create a hash table for the dictionary
    # accessing a hash that doesnt exist return nil
    lower.each do |word|
      if hashDictionary[word] != nil
        hashDictionary[word] +=1
      end
    end
  
    hashDictionary.each do |k, v|
  
      if v == nil || v == 0
        hashDictionary.delete(k)
      end
    end
    puts hashDictionary
  end
  
  dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  
  substrings("low low sit ## #@@#@##@1 21312", dictionary)