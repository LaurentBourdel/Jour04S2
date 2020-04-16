
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)

	page = Nokogiri::HTML(open(townhall_url))
	townhall_email= page.css('td')[7].text

	return townhall_email

end

def get_townhall_urls

	page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/val-d-oise.html"))
	total_numbers = 192
	count = 0
	list_url = []

	for index in 8..total_numbers
			url_at_index = page.css('a')[index]['href']
			list_url[count] = url_at_index
			list_url[count] = list_url[count].gsub!('./','https://www.annuaire-des-mairies.com/')
			count = count + 1
	end

	return list_url
end


def get_townhall_names(list_url)

	
	count = list_url.count
	list_names = []

	for index in 0..count -1
			list_names[index] = list_url[index]
			list_names[index] = list_names[index].gsub!('https://www.annuaire-des-mairies.com/','')
			list_names[index] = list_names[index].gsub!('.html','')
			list_names[index] = list_names[index].gsub!('/','')
			list_names[index] = list_names[index].gsub!("95","")
			list_names[index] = list_names[index].upcase
	end


	return list_names
end

def build_contact_hash

	
	page = Nokogiri::HTML(open("https://www.annuaire-des-mairies.com/95/ableiges.html"))

	list = []
	list = get_townhall_urls
	puts "> "
	puts "> Scrapping URL in progress.."
	e_mail = []
	for index in 0..list.count-1
	 	url_at_index = list[index]
		e_mail[index] = get_townhall_email(url_at_index)
		puts "> Scrapping E-mails in progress.. #{index+1}: #{e_mail[index]}" 
	end
	
	townhall_names = []
	townhall_names = get_townhall_names(list)
	puts "> "
	puts "> list des emails par villespour chaque villes:"
	puts "> "
	my_hash = townhall_names.zip(e_mail).to_h
	puts "> #{my_hash}"
	puts "> "


end

build_contact_hash