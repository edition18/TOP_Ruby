



class Game
  attr_reader :answer, :player_answer, :wrong_count, :tries_left, :correct_choices, :won
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
    
    print "\n" + @player_answer.split("").join(" ")
  end



  def play
    print @answer
    display_player_answer
    option_load
    loop do
      

      if @tries_left != 0
        option_save
        display_player_answer
        make_guess(gets.chomp)
      end

      if @won == true
        print "\n" + "you've WON!"
        exit
      end

      if @tries_left == 0
        print "\n" + "you've LOST!"
        print "\n" + "answer was #{@answer}"
        exit
      end

    end
  end

  def option_save
    # ask if player wants to save?
    print "\n" + "Y to save, else hit anything else to resume"
    input = gets.chomp
    if input.length == 1 && input.downcase == "y"
      #save
      #use self to save itself
      Marshal.dump(self, File.open('./projects/hangman/hangman_save.txt', 'w+')) 
      print "\n" + "save done, exiting game"
      exit
    else
      print "\n" + "Make your guess"
      return
    end
  end

  def option_load
    print "\n" + "Y to load from file, else hit anything else to resume"
    input = gets.chomp
    if input.length == 1 && input.downcase == "y"
      #load
      @loaded = Marshal.load(File.open('./projects/hangman/hangman_save.txt'))

      @answer = @loaded.answer
      @player_answer = @loaded.player_answer
      @wrong_count = @loaded.wrong_count
      @tries_left = @loaded.tries_left
      @correct_choices = @loaded.correct_choices
      @won = @loaded.won
      
      print "\n" + "Loaded, continue your game"
      display_player_answer
    else
      
      return
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
        word_array.push(row.strip.downcase)
      end
    end

    dictionary_file.close

    return word_array.sample
  end


  def make_guess(user_input)
    #make sure the answer is only 1 character

      print "\n" + "you guessed #{user_input.downcase}"
      #wrong input
      if user_input.length > 1 || (user_input.to_i.to_s.is_a? Integer) || user_input == ""
        print "please enter only 1 letter"

      # correct input, but already guessed
      elsif @player_answer.include?(user_input.downcase)
        print "You've already guessed that correctly"
      # correct input, and not yet guessed
      elsif !@answer.include?(user_input.downcase)
        wrong_guess
        return
      else
        @correct_choices.push(user_input.downcase)
        merge_guess_with_answer
        player_win_check
        display_player_answer
      end

  end

  def player_win_check
    (@player_answer <=> @answer) == 0 ? (@won = true; return) : "" 
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

    @player_answer = display_array.join("").clone
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


class Dummy
  attr_reader :spec, :age
  def initialize(spec,age)
    @spec = spec
    @age = age
  end
end

