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
				game.instance_variable_set(:@move, 3)
				game.board[5][2] = "\u001b[31m\u25cf"
			end

			it 'places marker on places marker on second row' do
				expect{game.place_marker}.to change{game.board[4][2]}
				game.place_marker
			end		
		end
	end
end

	