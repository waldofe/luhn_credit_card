module LuhnValidator
  def valid_number?
    number_sum % 10 == 0
  end

  def status
    valid_number? ? 'valid' : 'invalid'
  end

  private

    def number_sum
      number.split('').reverse.map.each_with_index do |number, i|
        ((i + 1).even? ? (number.to_i * 2) : number).to_s.split('')
      end.flatten.map(&:to_i).reduce(:+)
    end
end