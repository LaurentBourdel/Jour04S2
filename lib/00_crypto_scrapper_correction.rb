
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_prices(page)
	
	prices = []
	page.css("/html/body/div[1]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a/text()").each{|text| prices << text.content}
	#prices = page.xpath('//td[contains(@class, "cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price")]')
	
	prices.each_with_index do |value, index|
		prices[index] = prices[index].to_str
		prices[index] = prices[index].delete('* ')
		prices[index] = prices[index].delete('$')
		prices[index] = prices[index].delete(',')
		prices[index] = prices[index].to_f
	end

	return prices
end

def get_names(page)
	
	names = []
	page.css("/html/body/div[1]/div/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div/text()").each{|text| names << text.content}
	#names = page.xpath('//div[contains(@class, "sc-1p756ip-0 fhIunB")]')
	
	names.each_with_index do |value, index|
		names[index] = names[index].to_str
	end

	return names
end


def build_crypto_hash

	puts "> Scrapping in progress.."
	page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

	prices = get_prices(page)
	names = get_names(page)

	my_hash = names.zip(prices).map{|k, v| {"#{k}"=>v}}
	puts "> #{my_hash}"
	puts "> #{my_hash.count}"

end

build_crypto_hash