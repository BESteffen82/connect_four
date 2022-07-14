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

	describe '#play_round' do
		context 'when playing one turn by each player' do
			before do
				
			end
		end
	end
end
