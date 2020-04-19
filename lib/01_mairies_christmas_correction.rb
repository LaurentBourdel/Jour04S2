
require 'nokogiri'
require 'open-uri'

def get_townhall_url
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	townhall_urls = []
	page.xpath("//p/a/@href").each{|url| townhall_urls << "http://www.annuaire-des-mairies.com"+url.text[1..-1]}
	return townhall_urls
end

def get_townhall
	page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
	towns = []
	page.xpath("//p/a/text()").each{|town| towns << town.content}
	return towns
end

def get_townhall_email(townhall_urls)
	townhall_emails = []
	townhall_urls.each_with_index do |townhall_url, index|
		page = Nokogiri::HTML(open(townhall_url))
		page.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").each do |email|
			if email.content == ""
				townhall_emails << "Pas d'email" 
			else 
				townhall_emails << email.content
			end
			puts "> Scrapping E-mails in progress.. #{index+1}: #{email.content}"
		end
	end
	return townhall_emails
end

def main
	towns = get_townhall
	urls = get_townhall_url
	emails = get_townhall_email(urls)
	directory = towns.zip(emails).map{|k, v| {"#{k}"=>v}}
	puts " " 
	puts "#{directory}" 
end

main