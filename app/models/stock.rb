class Stock < ApplicationRecord
  def self.new_lookup(symbol)
    quote = StockService.get_quote(symbol)
    return nil if quote.blank? || quote["05. price"].blank?

    new(
      ticker: symbol.upcase,
      name: symbol.upcase,
      last_price: quote["05. price"].to_f
    )
  end
end
