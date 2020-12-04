class GuessOutcome
  attr_accessor :guess, :guess_num,:outcome
  def initialize(guess,guess_num)
    @guess = guess
    @guess_num = guess_num
    @outcome = Array.new(4)
  end
end


class Game
  attr_accessor :guess_count
  def initialize  
    @colors = ["Blue","Green","Red","Orange"]
    @answer = generate_answer
    @guess_count = 0
    @board = Array.new(12) {Array.new()}
  end

  def play
    #loop do
      print "\n" + "take your turn"
      # choice = make_turn
      @guess_count == 12 ? (print "You Lost"; return) : ""
      evaluate_guess?(human_choice).all? {|i| i == 1}
    #end
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

  # def evaluate_guess?(guess)
  #     i = 0
  #     while i < guess.length do
  #       guess[i] == @answer[i] ? "" : (add_guess_count; return false) 
  #     i = i + 1
  #     end
  #     add_guess_count
  #     return true 
  # end

  def evaluate_guess(guess)
    
    add_guess_count
    newGuess = GuessOutcome.new(guess,@guess_count)
    answer_sorted = @answer.sort
    guess_sorted = guess.sort
    p guess_sorted

    #find white balls first by sorting
    guess_sorted.each_with_index do |g, i|
      guess_sorted[i] == answer_sorted[i] ? (newGuess.outcome[i] = 0) : ("")
    end

    #update white balls to black, if applicable
    guess.each_with_index do |g, i|
      guess[i] == @answer[i] ? (newGuess.outcome[i] = 1) : ("")
    end
    
    return newGuess.outcome 
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
