



class Game
  attr_reader :answer
  def initialize
    
    @answer = get_answer_code
    @player_answer = censor_answer(@answer)
    @wrong_count = 0
    @tries_left = 8
    @correct_choices = []
    @won = false
  end

  def display_player_answer
    #print display = "\n" + @player_answer.split("").join(" ")
    print @answer
    print @player_answer.split("")
    
    print "\n" + @player_answer.split("").join(" ")
  end



  def play
    loop do
      display_player_answer
      print "n" + "Make your guess"
      make_guess(gets.chomp)

    end
  end

  def censor_answer(string)
    return replaced = string.gsub(/\w/,"_")
  end

  def get_answer_code
    path = IO.sysopen('./projects/hangman/5desk.txt')

    dictionary_file = IO.new(path)
    
    word_array = []
    # use strip to remove linebreaks and white space trailing
    # Strip. This method is sometimes called trim(): it removes all leading and trailing whitespace. Spaces, newlines, and other whitespace like tab characters are eliminated
    dictionary_file.each do |row|
      if row.strip.length >= 5 && row.strip.length <= 12
        word_array.push(row.strip)
      end
    end

    dictionary_file.close

    return word_array.sample
  end

  #by default ruby is case insensitive
  def make_guess(user_input)
    #make sure the answer is only 1 character
    loop do
      print "\n" + "you guessed #{user_input}"
      #wrong input
      if user_input.length > 1 || (user_input.to_i.to_s.is_a? Integer)
        print "please enter only 1 letter"
        user_input = gets.chomp
        next
      # correct input, but already guessed
      elsif @player_answer.include?(user_input)
        print "You've already guessed that correctly"
        user_input = gets.chomp
        next
      # correct input, and not yet guessed
      elsif !@answer.include?(user_input)
        wrong_guess
        return
      else
        @correct_choices.push(user_input)
        merge_guess_with_answer
        display_player_answer
      end
    end
  end

  def merge_guess_with_answer
    array = @answer.split("")
    display_array = @player_answer.split("")

    array.each_with_index do |alphabet, index|
      @correct_choices.each do |choice|
        if array[index] == choice
          display_array[index] = array[index]
        end
      end
    end

    @player_answer = display_array.clone
  end


  def wrong_guess
    print "\n" + "you've guesed wrong"
    add_to_wrong_counters

    print "\n" + "#{@tries_left} tries left"
  end

  def add_to_wrong_counters
    @wrong_count = @wrong_count + 1
    @tries_left = @tries_left - 1 
  end
end

Game.new.play


# answer = "timetogetspicy"
# display = "______________"

# guessed = ["t","e"]

# array = answer.split("")
# display_array = display.split("")

# p array

# array.each_with_index do |alphabet, index|
  
#   guessed.each do |guess|
#     if array[index] == guess
#       display_array[index] = array[index]
#     end
#   end
# end

# p display_array


# def censor_answer(string)
#     return replaced = string.gsub(/\w/,"x")
# end

# censored = censor_answer("test")

# print censored

# print "\n" + censored.split("").join(" ")

  # def censor_answer
  #   print @answer
  #   string ="test"
  #   print replaced = string.gsub(/\w/,"_").split("").join("|")
  #   return replaced = string.gsub(/\w/,"_")
  # end

  # censor_answer
