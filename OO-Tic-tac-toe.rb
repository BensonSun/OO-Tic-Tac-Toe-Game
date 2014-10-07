require 'pry'
class Board
	attr_accessor :board
	
	def initialize
	@board = {}
		(1..9).each do |i|
			@board[i] = " "
		end
	end

	def draw
		system ("cls")
		puts " #{board[1]} | #{board[2]} | #{board[3]}"
		puts "------------"
		puts " #{board[4]} | #{board[5]} | #{board[6]}"
		puts "------------"
		puts " #{board[7]} | #{board[8]} | #{board[9]}"
	end

	def empty_spaces
		board.select{|k,v| v == " "}.keys
	end

	def all_empty?
		board.any?{|k,v| v == " "}
	end

end

class Player
	attr_accessor :name
	def initialize(n)
		@name = n
	end

	def pick(b)
		loop do
			begin
				puts "#{name}, please choose a space(1-9): "
				n = gets.chomp.to_i
			end until (1..9).include?(n)
		chosen_space = b.board[n]
			if chosen_space == " "
			 	b.board[n] = "X"
			 	break
			else
			 	puts "#{name}, please choose an empty space!"
			end 
		end 
	end
end

class Computer
	def pick(b)
		empty = b.empty_spaces
		computer_pick = empty.sample
		b.board[computer_pick] = "O"
	end
end

class Game
	attr_accessor :win_situation

	def play(n)
		@win_situation = []
		player = Player.new(n)
		b = Board.new
		computer = Computer.new
		b.draw

		begin
			player.pick(b)
			computer.pick(b)
			check_winner(b,player)
			b.draw
		end until !b.all_empty? || win_situation.include?(1) || win_situation.include?(0)
		declare_winner
	end

	def check_winner(b,player)
		winner_lines = [[1, 2, 3], [1, 5, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [3, 5, 7], [4, 5, 6], [7, 8, 9]]
		winner_lines.each do |line|
				if b.board[line[0]] == "X" and b.board[line[1]] == "X" and b.board[line[2]] == "X"
					self.win_situation << 1 # 1 -->Player won
				elsif b.board[line[0]] == "O" && b.board[line[1]] == "O" && b.board[line[2]] == "O"
					self.win_situation << 0 # 0 -->Computer won
				elsif 
					self.win_situation << 2 # 2 -->it's a tie!
				end
		end
	end

	def declare_winner
		if win_situation.include?(1)
		puts "Player won!" 

		elsif win_situation.include?(0)
		puts "Computer won!"

		elsif win_situation.include?(2)
		puts "It's a tie!"
		end
	end
end

Game.new.play("Benson")