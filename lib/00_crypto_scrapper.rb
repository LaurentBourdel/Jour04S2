
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_prices(page)
	
	prices = []
	str_prices = []
	
	prices = page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price")]')
	prices.each_with_index do |value, index|
		str_prices[index] = prices[index].to_str
		str_prices[index] = str_prices[index].delete('* ')
		str_prices[index] = str_prices[index].delete('$')
		str_prices[index] = str_prices[index].delete(',')
		str = str_prices[index].to_f
	end

	return str_prices
end

def get_names(page)
	
	names = []
	str_names = []

	names = page.xpath('//div[contains(@class, "sc-1p756ip-0 fhIunB")]')
	names.each_with_index do |value, index|
		str_names[index] = names[index].to_str
		str = str_names[index]
		#puts "> #{str}"
	end

	return str_names
end

def get_pairs(page)
	
	pairs = []
	str_pairs = []

	pairs = page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__market-pair")]')

	pairs.each_with_index do |value, index|
		str_pairs[index] = pairs[index].to_str
		str = str_pairs[index]
		#puts "> #{str}"
	end

	return str_pairs
end

def build_crypto_hash

	puts "> Scrapping in progress.."
	page = Nokogiri::HTML(open("https://coinmarketcap.com/currencies/bitcoin/markets/"))

	prices = get_prices(page)
	names = get_names(page)
	pairs = get_pairs(page)

	names_pairs= []
	names.each_with_index do |value, index|
		names_pairs[index] = names[index] + " - " + pairs[index]
	end

	my_hash = names.zip(pairs).to_a
	my_hash = my_hash.zip(prices).to_h
	puts "> #{my_hash}"
	puts "> #{my_hash.count}"

end

build_crypto_hash