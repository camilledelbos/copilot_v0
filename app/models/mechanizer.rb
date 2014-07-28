# sudo gem install mechanize
require 'mechanize'
require 'csv'

agent = Mechanize.new


#Test
# agent.get('http://planificateur.a-contresens.net/climat-FI-HEL.html')
# # agent.page.search('table')
# # agent.page.search('table#climat_ville_tableau')
# # agent.page.parser.xpath("//table[@id='climat_ville_tableau']")
# # agent.page.parser.xpath("//table[@id='climat_ville_tableau']//tr").to_html
# # agent.page.parser.xpath("//table[@id='climat_ville_tableau']//tr//td").to_html
# agent.page.parser.xpath("//table[@id='climat_ville_tableau']//tr//td").map{ |n| n.text }
#

#pour chaque couple ville-aeroport appelle l'url agent.get('http://planificateur.a-contresens.net/climat-[COUPLE].html')
# couple = ["AM-V019", "JM-YGK", "BO-TDD", "AU-KTR"]

liens = []
table404 = []

#charge le fichier csv
csv = CSV.parse(File.open('db/couple.csv'))


csv.flatten.each do |couple|
  begin
    requete = "http://planificateur.a-contresens.net/climat-"+couple+".html"
    agent.get(requete)
  
    table = []

    table << couple
 
    ville = agent.page.search('tr')[0..-35].map { |row| row.search('td').map(&:text) }
    table << ville.flatten!
 
    entete = agent.page.parser.xpath("//table[@id='climat_ville_tableau']//*[name()='th']").map{ |n| n.text }
    table << entete
 
 climat = agent.page.parser.xpath("//table[@id='climat_ville_tableau']//*[name()='td']").map{ |n| n.text }
    table << climat

    lien << table

  rescue Mechanize::ResponseCodeError, Net::HTTPNotFound
    table404 << couple
  next
  end
  File.open("db/scrap/table_climat.yml", 'w') do |out|
  YAML.dump(liens, out)
  end
  File.open("db/scrap/table404.yml", 'w') do |out|
  YAML.dump(table404, out)
  end

end

# FileUtils.mkdir_p "db/scrap/"
File.open("db/scrap/table_climat.yml", 'w') do |out|
  YAML.dump(liens, out)
end

#en csv
## manque l'organisation en row
  CSV.open("db/scrap/table_climat.csv", "wb") do |csv|
  csv << liens
  end



#Code aeroport


a_z = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z"]
codes = []
a_z.each do |az|
  requete = "http://www.asia.com/airports/country/"+az+"/"
  agent.get(requete)
  table = []
  countup = count+1

  table << agent.page.parser.xpath("//table[@class='tbl']//tr[2]//td").map{ |n| n.text }
  codes << table
end










# Essai de standardisation
# source : http://www.scripts-seo.fr/topic-1396-tuto-ruby-scraper-un-annuaire-pour-remplir-le-sien-page-1.html

#création de l'agent mechanize
@agent = Mechanize.new

#page souhaité
url = 'http://www.asia.com/airports/country/'
    page = @agent.get(url)

#liste d'initialisation
@list_country_name = []
@list_airport_name = []
@list_city_name = []
@list_conutry_name = []
@list_world_area_name = []
@list_airport_code = []


row =

row.each_with_index do |tr,i|
     agent.page.parser.xpath("//table[@class='tbl']//"tr[i+1]"//td").map{ |n| n.text }



        ligne = row.search('//td[i+1]')
        @list_country_name << ligne
     end

  end
