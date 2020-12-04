class GuessFeedback
  attr_accessor :guess, :guess_num,:feedback
  def initialize(guess,guess_num)
    @guess = guess
    @guess_num = guess_num
    @feedback = Array.new()
  end
end


class Game
  attr_accessor :guess_count, :board, :answers_perm
  def initialize  
    @codes = [1,2,3,4,5,6]
    @answer = generate_answer
    @guess_count = 0
    @board = Array.new()
    @answers_perm = nil
  end

  def play
    print "Human Guess Pick 2 , else 1 for creator"
    
    loop do
      input = gets.chomp.to_i

      if input == 2 
        human_guesser
        return
      elsif input == 1
        set_answer
        computer_player
        return
      else
        print "please choose again"
      end
    end
  end

  def computer_player
    @answers_perm = @codes.repeated_permutation(4).to_a
    first_guess = [1,1,2,2]
    evaluate_guess?(first_guess)
    

    # case feedback
    #   when /\AX/
    #     "High risk"
    #   else
    #     "Unknown risk"
    # end
  end


  def set_answer
    @answer = human_choice
    print @answer
  end

  def human_guesser
    loop do
      # print "answer is #{@answer}"
      print "\n" + "take your turn"
      # choice = make_turn
      
      if evaluate_guess?(human_choice) == false
        print "you guessed wrong, try again"
        print "\n" + "Feedback = #{@board[@guess_count].feedback}"
      else
        print "You've WON!"
        return
      end
      
      @guess_count == 12 ? (print "You Lost"; return) : ""
      print "\n" + "#{12 - @guess_count} tries left"
    end
  end

  def generate_answer

    answer = []
    
    loop do

      answer.push(@codes.sample)
      if answer.length == 4
        break
      end
    end
    return answer
  end

  def evaluate_guess?(guess)
    add_guess_count
    
    newGuess = GuessFeedback.new(guess,@guess_count)
    
    temp_array = []
    guess_temp_array = guess.sort.clone
    answer_temp_array = @answer.sort.clone

    # if guess same as answer, just push the answer
    (guess <=> @answer) == 0 ? (@board.push(newGuess); return true) : "" 

    #add black values, if applicable
    guess.each_with_index do |g, i|
      guess[i] == @answer[i] ? (newGuess.feedback.push("B"); temp_array.push(guess[i])) : ("")
    end

    #push to temp array any answer that is correct
    #to be deleted from the temp answer array and guess
    temp_array.each do |ball|
      guess_temp_array.delete_at(guess_temp_array.index(ball))
      answer_temp_array.delete_at(answer_temp_array.index(ball))
    end
    guess_temp_array.each_with_index do |ball, k|
      if guess_temp_array[k] == answer_temp_array[k]
        newGuess.feedback.push("W")
      end
    end

    @board[@guess_count] = newGuess

    return false 
  end

  def add_guess_count
    @guess_count = @guess_count + 1
    #print "\n" + "Current Guess Count: #{@guess_count}"
  end


  def human_choice
    choice_array = []
    loop do
      print "\n" + "choose a code"

      @codes.each_with_index do |int, key|
        print "\n" + "#{key} #{int}"
      end
      input = gets.chomp.to_i
      
      while !@codes[input] do
          print "reenter valid values"
          input = gets.chomp.to_i
      end
      choice_array.push(@codes[input])
      
      

      if choice_array.length == 4
        return choice_array
      end
    end
  end


end

#Game.new.generate_answer
Game.new.play




# A simple strategy which is good and computationally much faster than Knuth's is the following (I have programmed both)

# Create the list 1111,...,6666 of all candidate secret codes

# Start with 1122.

# Repeat the following 2 steps:

# 1) After you got the answer (number of red and number of white pegs) eliminate from the list of candidates all codes that would not have produced the same answer if they were the secret code.

# 2) Pick the first element in the list and use it as new guess.

# This averages no more than 5 guesses.

# This is the Swaszek (1999-2000) strategy that was mentioned in another answer.
