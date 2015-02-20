require 'spec_helper'

describe PrettyPrinter do
  describe '#execute' do
    let(:credit_card) { CreditCard.new('4111111111111111\n') }
    let(:printer)     { PrettyPrinter.new(credit_card) }

    it 'returns a pretty string with credit_card information' do
      allow(credit_card).to receive(:type)   { 'VISA' }
      allow(credit_card).to receive(:status) { :valid }

      expect(printer.execute).to eq "VISA: 4111111111111111 (valid)"
    end
  end
end