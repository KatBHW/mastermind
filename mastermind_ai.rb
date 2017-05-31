class Guesser
  attr_reader :guess_array
  def initialize 
    @guess_array = ["-", "-", "-", "-"]
  end
end

class HumanGuesser < Guesser
  def make_guess 
    puts "Please enter your colours one at a time."
    puts "W = white, P = pink, Y = yellow, G = green, R = red, B = blue."
    position_number = 0 
    selections_made = 0
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
  end   
end      

class ComputerGuesser < Guesser
  def make_guess
    colours = ["W", "P", "Y", "G", "R", "B"]
    4.times do 
      @guess_array << colours[rand(colours.length)]
    end
  end 
end   

class Setter
  attr_reader :solution 
  def initialize
    @solution = []
  end
end  
  
class ComputerSetter < Setter
  def generate_solution
    colours = ["W", "P", "Y", "G", "R", "B"]
    4.times do 
      @solution << colours[rand(colours.length)]
    end
  end 
end   

class HumanSetter < Setter
  def generate_solution
    position_number = 0 
    selections_made = 0
    until selections_made == 4
      print "#{position_number + 1}: "
      user_input = gets.chomp.upcase
      if (user_input.length == 1) && (user_input =~ /[WPYGRB]/)
        @solution[position_number] = user_input
        position_number += 1
        selections_made += 1 
      else 
        puts "Invalid entry. Please try again."
      end
    end 
  end   
end   

class Game 
  attr_reader :guess_array, :solution, :guesser, :setter
  
  def initialize
    set_player_roles 
  end
  
  def set_player_roles
    puts "Would you like to guess or set the code?"
    puts "Type 'G' to guess or 'S' to set the code"
    user_input = gets.chomp.upcase
    if (user_input.length == 1) && (user_input =~ /[SG]/)
      user_role = user_input
    else 
      puts "Invalid entry. Please try again."
    end
    if user_role == "G"
      @guesser = HumanGuesser.new
      @setter = ComputerSetter.new
    else
      @guesser = ComputerGuesser.new
      @setter = HumanSetter.new 
    end 
  end   
  
  def display_board(board_array)
    puts "  1 " + " " + " 2 " + " " + " 3 " + " " + " 4 "
    puts "|" + " #{board_array[0]} " + "|" + " #{board_array[1]} " + "|" + " #{board_array[2]} " + "|" + " #{board_array[3]} " + "|"
    puts 
  end
  
  def check_common_values
    check = @solution.select do |x|
      @guess_array.include?(x) 
    end
    puts "#{check.length} colours correct"  
  end  

  def check_correct_positions
    correct_positions = 0 
    array_position = 0 
    until array_position == 4 
      if (@solution[array_position] == @guess_array[array_position])
        correct_positions += 1
      end 
      array_position += 1 
    end 
    puts "#{correct_positions} in the correct position."
  end

  def result
    if @guess_array == @solution
      puts "Guesser wins. The correct answer was:" 
    else 
      puts "Setter wins. The correct answer was:"
    end   
  end   
  
  def play_game 
    selections_left = 12
    counter = 0
    @setter.generate_solution
      until (counter == 12) || (@guess_array == @solution)
        display_board(@guess_array)
        @guesser.make_guess
        selections_left > 1? noun = "attempts" : noun = "attempt"
        puts "#{selections_left} #{noun} left"
        check_common_values
        check_correct_positions
        counter += 1 
        selections_left -= 1
      end
    result
   display_board(@solution)
    
  end 
end

game = Game.new
game.play_game