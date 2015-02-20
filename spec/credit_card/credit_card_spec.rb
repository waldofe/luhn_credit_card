require 'spec_helper'

describe CreditCard do
  context 'initial attributes' do
    describe '#number' do
      context 'when spaced number' do
        let(:credit_card) { CreditCard.new('3782 8224 6310 005') }

        it 'returns plain number' do
          expect(credit_card.number).to eq '378282246310005'
        end
      end

      context 'when number ends with \n' do
        let(:credit_card) { CreditCard.new('378282246310005\n') }

        it 'returns plain number' do
          expect(credit_card.number).to eq '378282246310005'
        end
      end

      context 'when spaced number and ends with \n' do
        let(:credit_card) { CreditCard.new('3782 8224 6310 005\n') }

        it 'returns plain number' do
          expect(credit_card.number).to eq '378282246310005'
        end
      end
    end
  end

  describe '#valid?' do
    context 'AMEX' do
      it 'when valid' do
        credit_card = CreditCard.new('3782 8224 6310 005')
        expect(credit_card.valid?).to eq true
      end

      it 'when invalid' do
        credit_card = CreditCard.new('3782 8224 6310 0051')
        expect(credit_card.valid?).to eq false
      end
    end

    context 'VISA' do
      it 'when valid' do
        credit_card = CreditCard.new('4111111111111111')
        expect(credit_card.valid?).to eq true
      end

      it 'when invalid' do
        credit_card = CreditCard.new('4111111111111')
        expect(credit_card.valid?).to eq false
      end
    end

    context 'MasterCard' do
      it 'when valid' do
        credit_card = CreditCard.new('5105105105105100')
        expect(credit_card.valid?).to eq true
      end

      it 'when invalid' do
        credit_card = CreditCard.new('5105105105105106')
        expect(credit_card.valid?).to eq false
      end
    end

    context 'Discover' do
      it 'when valid' do
        credit_card = CreditCard.new('6011111111111117')
        expect(credit_card.valid?).to eq true
      end

      it 'when invalid' do
        credit_card = CreditCard.new('6011 1111 1111 1127')
        expect(credit_card.valid?).to eq false
      end
    end
  end

  describe '#status' do
    let(:number)      { 'whatever 123' }
    let(:credit_card) { CreditCard.new(number) }

    it 'when true' do
      allow(credit_card).to receive(:valid?).and_return(true)

      expect(credit_card.status).to eq :valid
    end

    it 'when false' do
      allow(credit_card).to receive(:valid?).and_return(false)

      expect(credit_card.status).to eq :invalid
    end
  end

  describe '#type' do
    it 'when AMEX' do
      credit_card = CreditCard.new('378282246310005')
      expect(credit_card.type).to eq 'AMEX'
    end

    it 'when Discover' do
      credit_card = CreditCard.new('6011111111111117')
      expect(credit_card.type).to eq 'Discover'
    end

    it 'when MasterCard' do
      credit_card = CreditCard.new('5105 1051 0510 5106')
      expect(credit_card.type).to eq 'MasterCard'
    end

    it 'when VISA' do
      credit_card = CreditCard.new('4012888888881881')
      expect(credit_card.type).to eq 'VISA'
    end

    it 'when Unknown' do
      credit_card = CreditCard.new('9111111111111111')
      expect(credit_card.type).to eq 'Unknown'
    end
  end

  describe '.pretty_print_from_file(path)' do
    let(:file_path) do
      File.join(File.dirname(__FILE__), '..', 'support', 'credit_cards.txt')
    end

    it 'when path' do
      expect(CreditCard.pretty_print_from_file(file_path)).to eq(
        "VISA: 4111111111111111 (valid)
VISA: 4111111111111 (invalid)
VISA: 4012888888881881 (valid)
AMEX: 378282246310005 (valid)
Discover: 6011111111111117 (valid)
MasterCard: 5105105105105100 (valid)
MasterCard: 5105105105105106 (invalid)
Unknown: 9111111111111111 (invalid)"
      )
    end
  end
end