require_relative './player.rb'
require 'pry-byebug'

class ConnectFour	
	attr_accessor :board

	EMPTY_CIRCLE = "\e[37m\u25cb".freeze
	YELLOW_CIRCLE = "\u001b[33m\u25cf".freeze
	RED_CIRCLE = "\u001b[31m\u25cf".freeze

	def initialize
		@board = Array.new(6){Array.new(7){EMPTY_CIRCLE}}
		@player_one = nil  
		@player_two = nil 
	end
	
	def intro_message
		intro = <<-INTRO

Lets play Connect Four!

The first player to connect 4 pieces (horizontally, vertically, or diagonally) wins.

To place a piece, enter a column number (1 to 7).
INTRO
		puts intro
	end
end

new_game = ConnectFour.new
