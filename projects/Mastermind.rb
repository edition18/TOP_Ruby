class GuessFeedback
  attr_accessor :guess, :guess_num,:feedback
  def initialize(guess,guess_num)
    @guess = guess
    @guess_num = guess_num
    @feedback = Array.new(4)
  end
end


class Game
  attr_accessor :guess_count, :board
  def initialize  
    @colors = ["Blue","Green","Red","Orange"]
    @answer = generate_answer
    @guess_count = 0
    @board = Array.new()

  end

  def play
    loop do
      print "\n" + "take your turn"
      # choice = make_turn

      if evaluate_guess?(human_choice) == false
        print "you guessed wrong, try again"
        print "\n" + "Feedback = #{@board[@guess_count].feedback}"
      else
        print "You've WON!"
        return
      end
      add_guess_count
      @guess_count == 12 ? (print "You Lost"; return) : ""
      print "\n" + "#{12 - @guess_count} tries left"
    end
  end


  def generate_answer

    answer = []
    
    loop do

      answer.push(@colors.sample)
      if answer.length == 4
        break
      end
    end
    print "answer is #{answer}"
    return answer
  end

  def evaluate_guess?(guess)
    
    
    newGuess = GuessFeedback.new(guess,@guess_count)
    
    answer_sorted = @answer.sort
    guess_sorted = guess.sort

    # if guess same as answer, just push the answer
    (guess <=> @answer) == 0 ? (@board.push(newGuess); return true) : "" 
    

    #find white balls first by sorting
    guess_sorted.each_with_index do |g, i|
      guess_sorted[i] == answer_sorted[i] ? (newGuess.feedback[i] = "W") : ("")
    end

    #update white balls to black, if applicable
    guess.each_with_index do |g, i|
      guess[i] == @answer[i] ? (newGuess.feedback[i] = "B") : ("")
    end

    @board.push(newGuess)

    return false 
  end

  def add_guess_count
    @guess_count = @guess_count + 1
    #print "\n" + "Current Guess Count: #{@guess_count}"
  end


  def human_choice
    choice_array = []
    loop do
      print "\n" + "choose a color"

      @colors.each_with_index do |color, key|
        print "\n" + "#{key} #{color}"
      end
      input = gets.chomp.to_i
      
      while !@colors[input] do
          print "reenter valid values"
          input = gets.chomp.to_i
      end
      choice_array.push(@colors[input])
      print "i chose "
      print choice_array

      if choice_array.length == 4
        return choice_array
      end
    end
  end


end

#Game.new.generate_answer
Game.new.play
