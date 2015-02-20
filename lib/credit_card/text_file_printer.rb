require 'credit_card/pretty_printer'

class TextFilePrinter
  def self.parse(file_path)
    File.readlines(file_path).map do |number|
      PrettyPrinter.print( CreditCard.new(number) )
    end.join("\n")
  end
end