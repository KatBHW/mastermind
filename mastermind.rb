class Game 
  
  attr_reader :guess_array, :solution, :check
  
  def initialize
    @guess_array = ["-", "-", "-", "-"]
    @counter = 0
    @correct_positions = 0 
  end
  
  def generate_solution
    colours = ["W", "P", "Y", "G", "R", "B"]
    @solution = []
    4.times do 
      @solution << colours[rand(colours.length)]
    end
  end 
  
  def display_guess_board
    puts "  1 " + " " + " 2 " + " " + " 3 " + " " + " 4 "
    puts "|" + " #{@guess_array[0]} " + "|" + " #{@guess_array[1]} " + "|" + " #{@guess_array[2]} " + "|" + " #{@guess_array[3]} " + "|"
    puts 
  end
  
  def display_solution
    puts "  1 " + " " + " 2 " + " " + " 3 " + " " + " 4 "
    puts "|" + " #{@solution[0]} " + "|" + " #{@solution[1]} " + "|" + " #{@solution[2]} " + "|" + " #{@solution[3]} " + "|"
    puts 
  end
  
  def make_guess 
    @selections_made = 0 
    @position_number = 0 
    until @selections_made == 4
      print "#{@position_number + 1}: "
      @user_input = gets.chomp.upcase
      if (@user_input.length == 1) && (@user_input =~ /[WPYGRB]/)
        @guess_array[@position_number] = @user_input
        @position_number += 1
        @selections_made += 1 
      else 
        puts "Invalid entry. Please try again."
      end
    end  
  end       

  def check_common_values
    check = @solution.select do |x|
      @guess_array.include?(x) 
    end
  puts "#{check.length} colours correct"  
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
  
  def result
    if @guess_array == @solution
      puts "Well done. The correct answer was:" 
    else 
      puts "Bad luck. The correct answer was:"
    end   
  end     
    
  def play_game 
    selections_left = 12
    generate_solution
    puts "Please enter your colours one at a time."
    puts "W = white, P = pink, Y = yellow, G = green, R = red, B = blue."
      until (@counter == 12) || (@guess_array == @solution)
        selections_left > 1? noun = "attempts" : noun = "attempt"
        puts "You have #{selections_left} #{noun} left"
        display_guess_board
        make_guess
        check_common_values
        check_correct_positions
        @counter += 1 
        selections_left -= 1
      end
      result
      display_solution
  end 
  
end 

game = Game.new
game.play_game
  
