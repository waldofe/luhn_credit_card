require 'spec_helper'

describe CreditCard do
  describe '#valid_number?' do
    context 'AMEX' do
      it 'when valid' do
        credit_card = CreditCard.new('3782 8224 6310 005')
        expect(credit_card.valid_number?).to eq true
      end

      it 'when invalid' do
        credit_card = CreditCard.new('3782 8224 6310 0051')
        expect(credit_card.valid_number?).to eq false
      end
    end

    context 'VISA' do
      it 'when valid' do
        credit_card = CreditCard.new('4111111111111111')
        expect(credit_card.valid_number?).to eq true
      end

      it 'when invalid' do
        credit_card = CreditCard.new('4111111111111')
        expect(credit_card.valid_number?).to eq false
      end
    end

    context 'MasterCard' do
      it 'when valid' do
        credit_card = CreditCard.new('5105105105105100')
        expect(credit_card.valid_number?).to eq true
      end

      it 'when invalid' do
        credit_card = CreditCard.new('5105105105105106')
        expect(credit_card.valid_number?).to eq false
      end
    end

    context 'Discover' do
      it 'when valid' do
        credit_card = CreditCard.new('6011111111111117')
        expect(credit_card.valid_number?).to eq true
      end

      it 'when invalid' do
        credit_card = CreditCard.new('6011 1111 1111 1127')
        expect(credit_card.valid_number?).to eq false
      end
    end
  end

  describe '#status' do
    let(:credit_card) do
      class Klass
        include LuhnValidator
      end

      Klass.new
    end

    it 'when true' do
      allow(credit_card).to receive(:valid_number?).and_return(true)

      expect(credit_card.status).to eq 'valid'
    end

    it 'when false' do
      allow(credit_card).to receive(:valid_number?).and_return(false)

      expect(credit_card.status).to eq 'invalid'
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

  describe '#pretty_print' do
    it 'building' do
      credit_card = CreditCard.new('4111111111111111')

      allow(credit_card).to receive(:type)   { 'VISA' }
      allow(credit_card).to receive(:status) { 'valid' }

      expect(credit_card.pretty_print).to eq "VISA: 4111111111111111 (valid)"
    end
  end

  describe '.pretty_print_from_file(path)' do
    let(:file_path) do
      File.join(File.dirname(__FILE__), 'credit_cards.txt')
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