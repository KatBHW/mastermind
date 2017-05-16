class Game 
  
  attr_reader :guess_array, :solution, :check
  
  def initialize
    @guess_array = ["-", "-", "-", "-"]
    @counter = 0
    @correct_positions = 0 
    @check = Array.new(0)
  end
  
  def generate_solution
    @solution = "W P Y G R B".split(/\s/) 
    @solution.shuffle!
    2.times { @solution.pop }
  end 
  
  def display_guess_board
    puts "  1 " + " " + " 2 " + " " + " 3 " + " " + " 4 "
    puts "|" + " #{guess_array[0]} " + "|" + " #{guess_array[1]} " + "|" + " #{guess_array[2]} " + "|" + " #{guess_array[3]} " + "|"
    puts 
  end
  
  def display_solution
    puts "  1 " + " " + " 2 " + " " + " 3 " + " " + " 4 "
    puts "|" + " #{solution[0]} " + "|" + " #{solution[1]} " + "|" + " #{solution[2]} " + "|" + " #{solution[3]} " + "|"
    puts 
  end
  
  def make_guess 
    print "1: "
    @guess_array[0] = gets.chomp.upcase
    print "2: "
    @guess_array[1] = gets.chomp.upcase
    print "3: "
    @guess_array[2] = gets.chomp.upcase
    print "4: "
    @guess_array[3] = gets.chomp.upcase
  end
  
  def check_common_values
    @check = @guess_array & @solution
    puts "#{@check.length} colours correct" 
  end
  
  def check_correct_positions
    @correct_positions = 0 
      if (@solution[0] == @guess_array[0])
        @correct_positions += 1
      end   
      if (@solution[1] == @guess_array[1])
        @correct_positions += 1
      end   
      if (@solution[2] == @guess_array[2])
        @correct_positions += 1
      end   
      if (@solution[3] == @guess_array[3])
        @correct_positions += 1
      end
    puts "#{@correct_positions} in the correct position."
  end 
    
  def play_game 
    generate_solution
    puts "Please enter your colours one at a time."
    puts "W = white, P = pink, Y = yellow, G = green, R = red, B = blue."
      until (@counter == 12) || (@guess_array == @solution)
        display_guess_board
        make_guess
        check_common_values
        check_correct_positions
        @counter += 1 
      end
    display_solution
  end 
  
end 

game = Game.new
game.play_game
  
