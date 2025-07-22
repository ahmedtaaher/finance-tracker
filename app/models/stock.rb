class Stock < ApplicationRecord
  def self.new_lookup(symbol)
    quote = StockService.get_quote(symbol)
    return nil if quote.blank? || quote["05. price"].blank?
    name = StockService.get_company_name(symbol)
      new(
        ticker: symbol,
        name: name,
        last_price: quote["05. price"].to_f
      )
  end
end
