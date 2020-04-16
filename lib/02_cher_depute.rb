
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_deputés_names

	page = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
	total_number = 577
	
	name_at_index = []
	name_scan = []
	nom = []
	prenom = []
	e_mail = []

	for i in 0..total_number -1
			nom[i] = ""
			name_at_index[i] = page.css('option')[i+1].text
			name_scan = name_at_index[i].split(" ")

			name_scan.each_with_index do |value, index|
				if index == 0 
	 			end
	 			if index == 1 
	 				prenom[i] = name_scan[1]
				end
				if index > 1 
	 				nom[i] = nom[i] + name_scan[index]
	 			end
			end
	end

	for i in 0..total_number-1
			e_mail[i] = prenom[i] + "."  + nom[i] + "@assemblee-nationale.fr"
	end

	my_tab1 = nom.zip(prenom).to_h
	my_tab2 = my_tab1.zip(e_mail).to_h

	puts ">"
	puts "> Cher député: Nom, Prenom, email:"
	puts ">"
	puts "> #{my_tab2 }"
	puts ">"
	puts "> count = #{my_tab2.count}"
	puts ">"

	return my_tab2
end

def main

	get_deputés_names

end

main