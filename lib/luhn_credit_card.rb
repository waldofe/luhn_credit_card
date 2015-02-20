require 'luhn_credit_card/number_cleaner'
require 'luhn_credit_card/text_file_printer'
require 'luhn_credit_card/type_finder'
require 'luhn_credit_card/luhn_validator'

class LuhnCreditCard
  attr_reader :number

  def self.pretty_print_from_file(file_path)
    begin
      TextFilePrinter.parse(file_path)
    rescue => e
      # Log the error
      nil
    end
  end

  def initialize(number)
    @number = NumberCleaner.clean(number)
  end

  def type
    TypeFinder.for(number)
  end

  def valid?
    LuhnValidator.new(number).valid?
  end

  def status
    valid? ? :valid : :invalid
  end
end