class PrettyPrinter
  def initialize(card)
    @card = card
  end

  def execute
    "#{@card.type}: #{@card.number} (#{@card.status})"
  end
end