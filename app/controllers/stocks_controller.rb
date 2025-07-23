class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      @tracked_stocks = current_user.stocks

      respond_to do |format|
        if @stock
          format.js
          format.html { render "users/my_portfolio" }
        else
          flash.now[:alert] = "Stock not found. Please enter a valid stock ticker symbol to search."
          format.js
          format.html { render "users/my_portfolio" }
        end
      end
    else
      flash.now[:alert] = "Please enter a stock ticker symbol to search."

      respond_to do |format|
        format.js
        format.html { render "users/my_portfolio" }
      end
    end
  end
end
