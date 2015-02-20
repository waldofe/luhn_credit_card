class PrettyPrinter
  def self.print(card)
    "#{card.type}: #{card.number} (#{card.status})"
  end
end