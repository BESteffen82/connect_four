require_relative 'player'
require 'pry-byebug'

class ConnectFour	
	attr_accessor :player_one, :player_two, :move, :current_player, :board

	EMPTY_CIRCLE = "\e[37m\u25cb".freeze
	YELLOW_CIRCLE = "\u001b[33m\u25cf".freeze
	RED_CIRCLE = "\u001b[31m\u25cf".freeze

	def initialize
		@board = Array.new(6){Array.new(7,EMPTY_CIRCLE)}
		@player_one = nil  
		@player_two = nil							
	end

	def setup_game
		intro_message
		create_player_one
		create_player_two
		@current_player = [@player_one, @player_two].sample						
	end

	def play_game		
		setup_game		
		play_round 		
	end

	def play_round
		loop do
			print_board
			prompt_player
			@move = prompt_move
			@current_marker = @current_player.marker
			place_marker
			change_current_player
			connected_row		
		end						
	end		

	def intro_message
		intro = <<-INTRO

Lets play Connect Four!

The first player to connect 4 pieces (horizontally, vertically, or diagonally) wins.

To place a piece, enter a column number (1 to 7).
INTRO
		puts intro
	end

	def create_player_one
		puts "\nPlayer one, what is your name?"
		@player_one = Player.new(gets.chomp, YELLOW_CIRCLE)
		puts "\n"		
	end

	def create_player_two
		puts "Player two, what is your name?"
		@player_two = Player.new(gets.chomp, RED_CIRCLE)
		puts "\n"
	end

	def change_current_player
		@current_player = @current_player == @player_one? @player_two: @player_one				
	end

	def prompt_player
		puts "\e[37m#{@current_player.name} pick a column:"		
	end

	def prompt_move
    loop do
      @move = gets.chomp.to_i
      return @move if valid_move?(@move)

      puts "Invalid input. Enter a column number between 1 and 7"			
    end
  end

	def valid_move?(move)
    @move.is_a?(Integer) && @move.between?(1, 7) && @board[0][@move - 1] == EMPTY_CIRCLE
  end

	def place_marker
		for i in 5.downto(0)
			if @board[i][@move - 1] != EMPTY_CIRCLE
				next														
			else @board[i][@move - 1] = @current_marker
				return @board
			end
		end
	end
	
	def connected_four?
		return true if connected_row		
		return true if connected_column
		return true if connected_diagonally

		false
	end

	def connected_row
		count = 0

		@board.each do |row|
			for i in 0..5			
				unless row[i] == EMPTY_CIRCLE				
					if row[i] == row[i + 1] 
						count += 1						
						if count == 3
							return true
						end
					else
						count = 0					
					end					
				end
			end			
		end

		false
	end

	def connected_column
		count = 0	

		for i in 0..5
			for j in 0..4
				unless @board[j][i] == EMPTY_CIRCLE
					if @board[j][i] == @board[j + 1][i]
						count += 1
						if count == 3 
							return true
						end
					else 
						count = 0 
					end				
				end
			end				
		end

		false
	end

	def connected_diagonally
		return true if connected_diagonally_upward
		return true if connected_diagonally_downward
		
		false
	end

	def connected_diagonally_upward		
		for i in 0..3
			for j in 5.downto(3)
				unless @board[j][i] == EMPTY_CIRCLE
					if @board [j][i] == @board [j - 1][i + 1] &&
						@board [j][i] == @board [j - 2][i + 2] &&
						@board [j][i] == @board [j - 3][i + 3]

						return true
					else
						next
					end					
				end
			end
		end

		false
	end

	def connected_diagonally_downward		
		for i in 0..3
			for j in 0..2
				unless @board[j][i] == EMPTY_CIRCLE
					if @board [j][i] == @board [j + 1][i + 1] &&
						@board [j][i] == @board [j + 2][i + 2] &&
						@board [j][i] == @board [j + 3][i + 3]

						return true
					else
						next
					end					
				end
			end
		end

		false
	end
	
	def print_board
		puts 
		@board.each do |row|			
			row.each do |cell|
				print cell
				print ' '
			end
			print "\n"
		end
		puts "\u001b[96m1 2 3 4 5 6 7"
		puts		
	end	
end
