#Implement a method #stock_picker that takes in an array of stock prices,# one for each hypothetical day. It should return a pair of days 
# representing the best day to buy and the best day to sell. 
# Days start at 0.

def stock_picker(array)
    # assume you buy the stock everyday and held
    # then u sell it some point in future
    # store that combination somewhere
    # store that proft somewhere
    # should a new day combination profit be better
    # replace that set
  
    profit = 0
    i = 0
    while i < array.length - 1 do
      # array.length = 1 to provide for edge case 
      # if current element > all others left, continue
      # else, mark lowest combination and profit
      buy = array[i]
      sell = array[i + 1,array.length - 1].max
      currentProfit = sell - buy
      if currentProfit > profit
        profit = currentProfit
        buyIndex = array.find_index(buy)
        sellIndex = array.find_index(sell)
      end
      i = i + 1
    end
  
  
    answer = []
    answer.push(buyIndex)
    answer.push(sellIndex)
  
    if profit > 0 
      p answer
      p profit
    else
      p "not profitable"
    end
  
  
  end
  
   stock_picker([17,3,6,9,15,8,6,1,10])
  stock_picker([14,10])
  