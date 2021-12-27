require_relative '../lib/game'

describe Game do
  describe '#verify_input' do
    subject(:game_check) { described_class.new }

    context 'when given a valid input as argument' do
      it 'returns valid input' do
        user_input = '3'
        verified_input = game_check.verify_input(user_input)
        expect(verified_input).to eq('3')
      end
    end
    context 'when given a invalid input as argument' do
      it 'returns nil' do
        user_input = '8'
        verified_input = game_check.verify_input(user_input)
        expect(verified_input).to be_nil
      end
    end
  end
end
