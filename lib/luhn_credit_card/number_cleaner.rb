class NumberCleaner
  def self.clean(number)
    number.gsub(/\D+/, '')
  end
end