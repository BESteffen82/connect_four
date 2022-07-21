require_relative '../lib/connect_four'
require_relative '../lib/player'

describe ConnectFour do
  subject(:game) { described_class.new }
	let(:player){ double(Player) }

	describe '#create_player_one' do
		context 'when creating player one' do
			before do
			allow(game).to receive(:puts)
			allow(game).to receive(:gets).and_return('player_one')
			end

			it 'sends message to player one' do				
				expect(Player).to receive(:new).once
				game.create_player_one				
			end

			it 'assigns player one name' do
			expect{ game.create_player_one }.to change{ game.player_one }.to(Player)
			end		
		end
	end

	describe '#create_player_two' do
		context 'when creating player two' do
			before do
				allow(game).to receive(:puts)
				allow(game).to receive(:gets).and_return('player_two')
			end

			it 'sends message to player two' do				
				expect(Player).to receive(:new).once
				game.create_player_two				
			end

			it 'assigns player two name' do
			expect{ game.create_player_two }.to change{ game.player_two }.to(Player)
			end		
		end
	end

	describe '#prompt_move' do
		context 'move is a valid input' do
			before do
				allow(game).to receive(:gets).and_return("3\n")
			end

			it 'returns move and stops the loop' do
				error_message = 'Invalid input. Enter a column number between 1 and 7'
				expect(game).to_not receive(:puts).with(error_message)
				game.prompt_move
			end
		end

		context 'when given one invalid input, then a valid input' do
			before do
				letter = 'a'
				valid_input = '1'
				allow(game).to receive(:gets).and_return(letter, valid_input)
			end

			it 'completes loop and displays error message once' do
				error_message = 'Invalid input. Enter a column number between 1 and 7'
				expect(game).to receive(:puts).with(error_message).once
				game.prompt_move
			end
		end
	end

	describe '#change_current_player' do
		context 'when player_one turn is over' do
			before do
				game.instance_variable_set(:@player_one, instance_double(Player))
				game.instance_variable_set(:@player_two, instance_double(Player))
			end

			it 'switches turns from player_one to player_two' do
				game.instance_variable_set(:@current_player, game.player_one)				
				expect{game.change_current_player}.to change{game.current_player}.to(game.player_two)
			end		
		end
	end

	describe '#place_marker' do		
		context 'when column is empty' do			
			before do															
				game.instance_variable_set(:@move, 4)
				game.instance_variable_set(:@player_one, instance_double(Player))				
			end

			it 'places marker on bottom row' do				
				game.instance_variable_set(:@current_player, game.player_one)						
				expect{game.place_marker}.to change{game.board[5][3]}						
			end
		end

		context 'when column is not empty, but filled with one marker' do
			before do
				RED_CIRCLE = "\u001b[31m\u25cf"					
				game.board[5][2] = RED_CIRCLE				
				game.instance_variable_set(:@move, 3)
				game.instance_variable_set(:@player_two, instance_double(Player))				
			end

			it 'places marker on places marker on second row' do				
				game.instance_variable_set(:@current_player, game.player_two)						
				expect{game.place_marker}.to change{game.board[4][2]}							
			end		
		end	
	end
	
	describe '#connected_four?' do
		context 'when four markers are connected in a row' do
			before do				
				game.board[2][3] = RED_CIRCLE
				game.board[2][4] = RED_CIRCLE
				game.board[2][5] = RED_CIRCLE
				game.board[2][6] = RED_CIRCLE				
			end

			it 'returns true' do
				expect(game.connected_four?).to be true
			end
		end

		context 'when there are no rows of four connected markers' do
			before do				
				game.board[2][1] = RED_CIRCLE
				game.board[2][4] = RED_CIRCLE
				game.board[2][5] = RED_CIRCLE
				game.board[2][6] = RED_CIRCLE				
			end

			it 'returns false' do
				expect(game.connected_four?).to be false
			end
		end

		context 'when four markers are connected in a column' do
			before do
				game.board[4][1] = RED_CIRCLE
				game.board[3][1] = RED_CIRCLE
				game.board[2][1] = RED_CIRCLE
				game.board[1][1] = RED_CIRCLE			
			end

			it 'returns true' do
				expect(game.connected_four?).to be true
			end
		end

		context 'when there are no columns of four connected markers' do
			before do
				game.board[5][1] = RED_CIRCLE
				game.board[3][1] = RED_CIRCLE
				game.board[2][1] = RED_CIRCLE
				game.board[1][1] = RED_CIRCLE			
			end

			it 'returns false' do
				expect(game.connected_four?).to be false
			end
		end

		context 'when there are four markers connected diagonally upward' do
			before do
				game.board[5][2] = RED_CIRCLE
				game.board[4][3] = RED_CIRCLE
				game.board[3][4] = RED_CIRCLE
				game.board[2][5] = RED_CIRCLE
			end
			
			it 'returns true' do
				expect(game.connected_four?).to be true
			end
		end

		context 'when there are four markers connected diagonally downward' do
			before do
				game.board[1][1] = RED_CIRCLE
				game.board[2][2] = RED_CIRCLE
				game.board[3][3] = RED_CIRCLE
				game.board[4][4] = RED_CIRCLE
			end
			
			it 'returns true' do
				expect(game.connected_four?).to be true
			end
		end

		context 'when there are not four markers connected diagonally' do
			before do
				game.board[1][4] = RED_CIRCLE
				game.board[2][2] = RED_CIRCLE
				game.board[3][3] = RED_CIRCLE
				game.board[4][4] = RED_CIRCLE
			end
			
			it 'returns true' do
				expect(game.connected_four?).to be false
			end
		end
	end

	describe '#board_full' do
		context 'when there are no empty slots' do
			before do				
				YELLOW_CIRCLE = "\u001b[33m\u25cf"
				game.board[0][0] = RED_CIRCLE
				game.board[0][1] = YELLOW_CIRCLE
				game.board[0][2] = RED_CIRCLE
				game.board[0][3] = YELLOW_CIRCLE
				game.board[0][4] = RED_CIRCLE
				game.board[0][5] = YELLOW_CIRCLE
				game.board[0][6] = RED_CIRCLE
			end
			
			it 'returns true' do
				expect(game.board_full).to be true
			end
		end

		context 'when there are empty slots' do
			before do
				EMPTY_CIRCLE = "\e[37m\u25cb"								
				game.board[0][0] = RED_CIRCLE
				game.board[0][1] = YELLOW_CIRCLE
				game.board[0][2] = RED_CIRCLE
				game.board[0][3] = EMPTY_CIRCLE
				game.board[0][4] = RED_CIRCLE
				game.board[0][5] = YELLOW_CIRCLE
				game.board[0][6] = EMPTY_CIRCLE
			end
			
			it 'returns true' do
				expect(game.board_full).to be false
			end
		end
	end
end

	