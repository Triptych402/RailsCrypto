class HomeController < ApplicationController
  def index
  	#require 'net/http'
  	#require 'json'

  	@url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=f20de4a4-9bf9-4a57-bdb0-e68559b87260&start=1&limit=5000&convert=USD'
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@coins = JSON.parse(@response)
  	@my_coins = ["WRX", "TRU", "XLM", "BTC"]
  end
  def about
  end

  def lookup

  	require 'net/http'
  	require 'json'

  	@url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=f20de4a4-9bf9-4a57-bdb0-e68559b87260&start=1&limit=5000&convert=USD'
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@lookup_coin = JSON.parse(@response)

  	@symbol = params[:sym]
  	if @symbol
  		@symbol = @symbol.upcase
  	end
  	if @symbol == ""
  		@symbol = "타입해라!"
  	end

  end	
end
