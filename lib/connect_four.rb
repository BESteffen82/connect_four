require_relative './player.rb'
require 'pry-byebug'

class ConnectFour	
	attr_reader :board
	attr_accessor :player_one, :player_two


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
	end

	def play_game		
		setup_game		
		print_board
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
	
	def print_board
		puts 
		@board.each do |row|			
			row.each do |cell|
				print cell
				print ' '
			end
			print "\n"
		end
		puts "\u001b[96m0 1 2 3 4 5 6"
		puts		
	end
end

new_game = ConnectFour.new
new_game.play_game
