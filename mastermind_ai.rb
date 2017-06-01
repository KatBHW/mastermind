class Game
  def initialize; end
end

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

class Computer 
  attr_reader :solution
  
  def initialize
    @solution = []
  end
  
  def generate_solution
    colours = ["W", "P", "Y", "G", "R", "B"]
    4.times { @solution << colours[rand(colours.length)] }
  end 
end
  
class Player 
  attr_reader :guess_array
  
  def initialize
    @guess_array = []
  end
  
  def make_guess
    colours = ["W", "P", "Y", "G", "R", "B"]
    4.times { @guess_array << colours[rand(colours.length)] }
  end 
end   

guesser = Player.new
setter = Computer.new 
setter.generate_solution
guesser.make_guess
guess_board = Board.new(guesser.guess_array)
solution_board = Board.new(setter.solution)
puts "Guess:"
guess_board.display_board
puts "Solution:"
solution_board.display_board
