require 'spec_helper'

class NumberCleaner
  def self.clean(number)
    number.sub('\n', '').gsub(' ', '').chomp
  end
end