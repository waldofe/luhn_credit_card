require 'pry'
require 'credit_card/pretty_printer'

class TextFilePrinter
  def initialize(file_path)
    @file_path = file_path
  end

  def execute
    File.readlines(@file_path).map do |number|
      PrettyPrinter.new( CreditCard.new(number) ).execute
    end.join("\n")
  end
end