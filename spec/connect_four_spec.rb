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
				allow(game).to receive(:gets).and_return('3\n')
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
				valid_input = '2'
				allow(game).to receive(:gets).and_return(letter, valid_input)
			end

			it 'completes loop and displays error message once' do				
				error_message = 'Invalid input. Enter a column number between 1 and 7'				
				expect(game).to receive(:puts).with(error_message).once
				game.prompt_move
			end
		end
	end
end
