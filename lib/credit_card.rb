require 'credit_card/text_file_printer'
require 'credit_card/type_finder'
require 'credit_card/luhn_validator'

class CreditCard
  attr_reader :number

  def self.pretty_print_from_file(file_path)
    TextFilePrinter.new(file_path).execute
  end

  def initialize(number)
    @number = number.sub('\n', '').gsub(' ', '').chomp
  end

  def type
    TypeFinder.new(number).execute
  end

  def valid?
    LuhnValidator.new(number).execute
  end

  def status
    valid? ? :valid : :invalid
  end
end