require 'luhn_validator'

class CreditCard
  include LuhnValidator

  CHARACTERISTICS = {
    'AMEX'       => { begins_with: ['34', '37'],      length: [15] },
    'Discover'   => { begins_with: ['6011'],          length: [16] },
    'MasterCard' => { begins_with: ('51'..'55').to_a, length: [16] },
    'VISA'       => { begins_with: ['4'],             length: [13, 16] }
  }

  attr_reader :number

  def initialize(number)
    @number = number.gsub(' ', '')
  end

  def pretty_print
    "#{type}: #{number} (#{status})"
  end

  def self.pretty_print_from_file(file_path)
    File.readlines(file_path).map do |number|
      self.new(number.sub("\n", '')).pretty_print
    end.join("\n")
  end

  def type
    CHARACTERISTICS.detect do |card, settings|
      return card if settings[:begins_with].detect {
        |n_start| number.start_with? n_start
      } && settings[:length].include?(number.size)
    end

    'Unknown'
  end
end