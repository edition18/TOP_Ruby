



class Game
  attr_reader :answer
  def initialize
    
    @answer = get_answer_code
    @display_answer = censor_answer(@answer)
    @wrong_count = 0
    @tries_left = 8
    @correct_choices = []
    @won = false

    print @answer
  end


  def play
    loop do
      print "Make your guess"
      make_guess(gets.chomp)

    end
  end

  def censor_answer(string)
    replaced = string.gsub(/\w/,"_")
  end

  def get_answer_code
    path = IO.sysopen('./projects/hangman/5desk.txt')

    dictionary_file = IO.new(path)
    
    word_array = []

    dictionary_file.each do |row|
      if row.length >= 5 && row.length <= 12
        word_array.push(row)
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
      elsif @display_answer.include?(user_input)
        print "You've already guessed that correctly"
        user_input = gets.chomp
        next
      # correct input, and not yet guessed
      elsif !@answer.include?(user_input)
        wrong_guess
        return
      else
        @correct_choices.push(user_input)
      end
    end
  end

  def render_display_answer
    #for every alphabet in @correct_choices
    #
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

# Game.new.play
