require "net/http"
require "json"

class StockService
  BASE_URL = "https://www.alphavantage.co/query"

  def self.get_quote(symbol)
    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(
      function: "GLOBAL_QUOTE",
      symbol: symbol,
      apikey: Rails.application.credentials.dig(:alpha_vantage, :api_key)
    )

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    data["Global Quote"]
  rescue => e
    Rails.logger.error("Alpha Vantage error: #{e.message}")
    nil
  end
end
