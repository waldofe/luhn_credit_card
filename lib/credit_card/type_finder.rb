class TypeFinder
  CHARACTERISTICS = {
    'AMEX'       => { begins_with: ['34', '37'],      length: [15] },
    'Discover'   => { begins_with: ['6011'],          length: [16] },
    'MasterCard' => { begins_with: ('51'..'55').to_a, length: [16] },
    'VISA'       => { begins_with: ['4'],             length: [13, 16] }
  }

  def initialize(number)
    @number = number
  end

  def execute
    CHARACTERISTICS.detect do |card, settings|
      return card if settings[:begins_with].detect {
        |n_start| @number.start_with? n_start
      } && settings[:length].include?(@number.size)
    end

    'Unknown'
  end
end