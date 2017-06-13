# NEED TO ADD SOME BLOCKS TO DRY OUT
# POSSIBLY ADD BLOCK CLASS? 
# NEED TO SEPARATE INTO DIFFERENT FILES AND REQUIRE IN

class Game 
  
  attr_reader :solution_array, :guess_array
  
  def initialize
    @solution_array = []
    @guess_array = ["-", "-", "-", "-"]
  end
  
  def set_player_roles
    puts "Would you like to guess (G) or set (S) the code?"
    puts "Please type 'G' or 'S'."
    role_decision = gets.chomp.upcase!
    if role_decision == "G"
      @guesser = HumanGuesser.new
      @setter = ComputerSetter.new
    elsif role_decision == "S"
      @guesser = ComputerGuesser.new
      @setter = HumanSetter.new
    else
      raise "That is not a valid choice."
    end  
  end
  
  def display_board(board_array)
    puts "  1 " + " " + " 2 " + " " + " 3 " + " " + " 4 "
    puts "|" + " #{board_array[0]} " + "|" + " #{board_array[1]} " + "|" + " #{board_array[2]} " + "|" + " #{board_array[3]} " + "|"
    puts 
  end

  def check_common_values
    check = @solution_array.select do |x|
      @guess_array.include?(x) 
    end
    if check.length == 1? noun = "colour" : noun = "colours"
      puts "#{check.length} #{noun} correct."  
    end
  end 

  def check_correct_positions
    correct_positions = 0 
    @array_position = 0 
    until @array_position == 4 
      if (@solution_array[@array_position] == @guess_array[@array_position])
        correct_positions += 1
      end 
      @array_position += 1 
    end 
    puts "#{correct_positions} in the correct position."
  end

  def result
    if @guess_array == @solution_array
      puts "Well done. The correct answer was:" 
    else 
      puts "Bad luck. The correct answer was:"
    end   
  end     
    
  def play_game 
#TEMPORARILY SET AT THREE TURNS TO EASE TESTING.  
    selections_left = 3
    @solution_array = @setter.generate_solution
#TEMPORARILY GIVING AWAY SOLUTION TO EASE TESTING.
    display_board(@solution_array)
    counter = 0 
    puts "Please enter your colours one at a time."
    puts "W = white, P = pink, Y = yellow, G = green, R = red, B = blue."
      until (counter == 3) || (@guess_array == @solution_array)
        selections_left > 1? noun = "attempts" : noun = "attempt"
        puts "You have #{selections_left} #{noun} left" 
#TEXT IS ODD WHEN HUMAN IS SETTING AND COMPUTER IS GUESSING - NEED TO LOOK AT ORDER OF PUTS STATMENTS
        display_board(@guess_array)
        @guess_array = @guesser.make_guess
        check_common_values
        check_correct_positions
        counter += 1 
        selections_left -= 1
        
      end
      result
      display_board(@solution_array)
  end 
  
end 
  
class Setter 
  attr_reader :solution_array
  def initialize
    @solution_array = []
  end
end

class ComputerSetter < Setter

  def initialize
   super
  end

  def generate_solution
    colours = ["W", "P", "Y", "G", "R", "B"]
    4.times { @solution_array << colours[rand(colours.length)] }
    @solution_array
  end 
end

class HumanSetter < Setter
  def initialize
   super
  end
  
  def generate_solution 
    selections_made = 0 
    position_number = 0 
    puts "Please enter your colours one at a time."
    puts "W = white, P = pink, Y = yellow, G = green, R = red, B = blue."
    until selections_made == 4
      print "#{position_number + 1}: "
      user_input = gets.chomp.upcase
      if (user_input.length == 1) && (user_input =~ /[WPYGRB]/)
        @solution_array[position_number] = user_input
        position_number += 1
        selections_made += 1 
      else 
        puts "Invalid entry. Please try again."
      end
    end  
    @solution_array
  end  
end

class Guesser
  attr_reader :guess_array
  def initialize
    @guess_array = ["-", "-", "-", "-"]
  end
end

class HumanGuesser < Guesser  
  
  def initialize
   super
  end
  
  def make_guess 
    selections_made = 0 
    position_number = 0 
    until selections_made == 4
      print "#{position_number + 1}: "
      user_input = gets.chomp.upcase
      if (user_input.length == 1) && (user_input =~ /[WPYGRB]/)
        @guess_array[position_number] = user_input
        position_number += 1
        selections_made += 1 
      else 
        puts "Invalid entry. Please try again."
      end
    end  
    @guess_array
  end  
end    

class ComputerGuesser < Guesser
  def initialize
   super
  end
   
  def make_guess 
    colours = ["W", "P", "Y", "G", "R", "B"]
    @guess_array = []
    4.times { @guess_array << colours[rand(colours.length)] }
    @guess_array
# ADD AI HERE
  end 
end
  
game = Game.new
game.set_player_roles
game.play_game
  


=begin
Basic AI code
class ComputerGuesser < Guesser
  def make_guess
    kept_colours = []
    solution_array = @setter.solution_array
    4.times { @guess_array << colours[rand(colours.length)] }
    puts "guess array = #{@guess_array}"
    solution_array.each { |x| kept_colours << x if @guess_array.include?(x) }
    @guess_array = kept_colours
    puts "kept_colours = #{kept_colours}"
    until @guess_array.length == 4
      @guess_array << colours[rand(colours.length)]
    end 
    puts @guess_array
    end
end
First draft of setter, guesser and board classes
class Board
  attr_reader :board_array
  
  def initialize(board_array)
    @board_array = board_array
  end 
  
  def display_board
    puts "  1 " + " " + " 2 " + " " + " 3 " + " " + " 4 "
    puts "|" + " #{board_array[0]} " + "|" + " #{board_array[1]} " + "|" + " #{board_array[2]} " + "|" + " #{board_array[3]} " + "|"
    puts 
  end
end
class Setter 
  attr_reader :solution_array
  
  def initialize
    @solution_array = []
  end
  
  def generate_solution
    colours = ["W", "P", "Y", "G", "R", "B"]
    4.times { @solution_array << colours[rand(colours.length)] }
  end 
end
  
class Guesser 
  attr_reader :guess_array
  
  def initialize
    @guess_array = []
  end
  
  def make_guess
    colours = ["W", "P", "Y", "G", "R", "B"]
    4.times { @guess_array << colours[rand(colours.length)] }
  end 
end   
setter = Setter.new
guesser = Guesser.new 
setter.generate_solution
guesser.make_guess
guess_board = Board.new(guesser.guess_array)
solution_board = Board.new(setter.solution_array)
puts "Guess:"
guess_board.display_board
puts "Solution:"
solution_board.display_board
=end