class Game
  attr_accessor :guess_count, :board, :answers_perm, :current_key_pegs, :current_guess, :current_feedback, :computer_won
  def initialize  
    @codes = [1,2,3,4,5,6]
    @answer = generate_answer
    @guess_count = 0
    @board = Array.new()
    @answers_perm = @codes.repeated_permutation(4).to_a
    @current_key_pegs = 0
    @current_guess = nil
    @current_feedback = []
    @computer_won = false
  end

  def play
    print "1 for Human Code Creator,Human Guess Pick 2"
    
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
    first_guess = [1,1,2,2]
    loop do
      if @guess_count == 0 
        computer_attempt(first_guess)
      elsif guess_count == 12
        print "\n" + "computer lost"
        return
      else
        computer_attempt(next_guess)
      end

      if @computer_won == true
        print "\n" + "computer won"
        return
      end
    end
  end

  def computer_attempt(guess)
    clear_current_key_pegs
    add_guess_count
    clear_current_feedback
    
    @current_guess = guess
    print "\n" + "computer guesses #{guess} on guess number #{@guess_count}"

    (guess <=> @answer) == 0 ? (@computer_won = true; return) : "" 

    #if have not won

    #reduce array down
    @current_key_pegs = return_key_pegs(guess, @answer)
    
    answers_perm_reducer(guess)

  end

  def clear_current_key_pegs
    @current_key_pegs = 0
  end

  def next_guess

      return @answers_perm[0]

  end

  def answers_perm_reducer(current_guess)
    #this aims to reduce the permutations down
    #based on looking at the current 
    
    temp_array = []
    @answers_perm.each do |p|
      if return_key_pegs(p, current_guess) == @current_key_pegs
        temp_array.push(p)
      end
    end

    @answers_perm = temp_array.clone
    print "\n" + "permutations left #{@answers_perm.count}"
  end

  def set_answer
    print "set your answer"
    @answer = human_choice
    print @answer
  end

  def human_guesser
    print "answer is #{@answer}"
    
    loop do  
      print "\n" + "take your turn"
      # choice = make_turn
      
      if evaluate_guess?(human_choice, @answer) == false
        print "you guessed wrong, try again"
        print "\n" + "Feedback = #{@current_feedback}"
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

  def clear_current_feedback
    @current_feedback = []
  end

  def return_key_pegs(guess, compare_against)
    count = 0
    temp_array = []
    #if we have direct match at index, we have black pegs
    #we need store these somewhere (A)
    guess.each_with_index do |ele, i|
      guess[i] == compare_against[i] ? (count = count + 1; temp_array.push(guess[i])) : ("")
    end

    #following which we remove each element in A from a duplicate of the guess array and answer array

    temp_guess = guess.clone
    temp_compare_against = compare_against.clone
    temp_array.each do |item|
        temp_guess.delete_at(temp_guess.index(item))
        temp_compare_against.delete_at(temp_compare_against.index(item))
    end
    #then we run every element of that reduced duplicate array against the answer array, if it is included then we add to white peg and then delete that item (prevent double count)
    temp_guess.each do |item|
        if temp_compare_against.include?(item)
          count = count + 1
        temp_compare_against.delete_at(temp_compare_against.index(item))
      end
    end
    return count
  end

  def evaluate_guess?(guess, compare_against)
    add_guess_count
    clear_current_feedback
    @current_guess = guess
    
    temp_array = []
    guess_temp_array = guess.sort.clone
    compare_against_temp = compare_against.sort.clone

    # if guess same as answer, just push the answer
    (guess <=> @answer) == 0 ? (return true) : "" 

    #add black values, if applicable
    guess.each_with_index do |g, i|
      guess[i] == @answer[i] ? (@current_feedback.push("B"); temp_array.push(guess[i])) : ("")
    end

    #push to temp array any answer that is correct
    #to be deleted from the temp answer array and guess
    temp_array.each do |ball|
      guess_temp_array.delete_at(guess_temp_array.index(ball))
      compare_against_temp.delete_at(compare_against_temp.index(ball))
    end
    guess_temp_array.each_with_index do |ball, k|
      if guess_temp_array[k] == compare_against_temp[k]
        @current_feedback.push("W")
      end
    end
    return_key_pegs(guess,compare_against)
    print "\n" +"Your guess was #{@current_guess}"
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


