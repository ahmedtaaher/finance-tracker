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

  def self.get_company_name(symbol)
    uri = URI(BASE_URL)
    uri.query = URI.encode_www_form(
      function: "SYMBOL_SEARCH",
      keywords: symbol,
      apikey: Rails.application.credentials.dig(:alpha_vantage, :api_key)
    )

    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    match = data["bestMatches"]&.find do |match|
      match["1. symbol"].casecmp(symbol).zero?
    end

    match ? match["2. name"] : symbol.upcase
  rescue => e
    Rails.logger.error("Company name lookup error: #{e.message}")
    symbol.upcase
  end
end
