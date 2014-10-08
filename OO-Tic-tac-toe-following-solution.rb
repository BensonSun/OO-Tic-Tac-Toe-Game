class Board
	WINNER_LINES =  [[1, 2, 3], [1, 5, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [3, 5, 7], [4, 5, 6], [7, 8, 9]]
	attr_accessor :data
	def initialize
		@data = {}
		(1..9).each do |n| 
			@data[n] = Square.new(' ')
		end
	end

	def draw
		system ("cls")
		puts " #{data[1]} | #{data[2]} | #{data[3]}"
		puts "-----------"
		puts " #{data[4]} | #{data[5]} | #{data[6]}"
		puts "-----------"
		puts " #{data[7]} | #{data[8]} | #{data[9]}"
	end

	def all_empty_squares?
		empty_squares.size != 0
	end

	def empty_squares
		@data.select{|k,v| v.value == ' '}.values
	end

	def empty_positions
		@data.select{|k,v| v.value == ' '}.keys
	end

	def all_occupied?
		empty_squares.size == 0
	end

	def mark_square(position, marker)
		@data[position].value = marker
	end
end

class Square
	attr_accessor :value
	
	def initialize(v)
		@value = v
	end

	def to_s
		@value
	end
end


class Player
	attr_reader :name, :marker

	def initialize(name,marker)
		@name = name
		@marker = marker
	end

	
end

class Game
	def initialize
		@board = Board.new
		@player = Player.new("Benson", "X")
		@computer = Player.new("X486", "O")
		@current_player = @player
	end

	def play
		@board.draw
		loop do
			@board.draw
			current_player_mark
				if current_player_win?(@current_player.marker)
					@board.draw
					puts "#{@current_player.name} won!"
					break

				elsif @board.all_occupied? 
					@board.draw
					puts "It's a tie!"
					break

				else
					alternate_player		
				end
		end 
	end

	def current_player_mark
		if @current_player == @player
			begin
				puts "#{@player.name}, please pick a square (1-9) :"
				position = gets.chomp.to_i
			end until @board.empty_positions.include?(position)
		else 
			position = @board.empty_positions.sample
		end
		@board.mark_square(position, @current_player.marker)
	end

	def alternate_player
		if @current_player == @player
			@current_player = @computer
		else
			@current_player = @player
		end
	end

	def current_player_win?(marker)
		Board::WINNER_LINES.each do |line|
			return true if @board.data[line[0]].value == marker && @board.data[line[1]].value == marker && @board.data[line[2]].value == marker
		end
		return false
	end

end

Game.new.play