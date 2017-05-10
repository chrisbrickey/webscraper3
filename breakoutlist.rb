require 'nokogiri'
require 'open-uri'
require 'json'
require 'csv'


#Parameters must be in string format e.g. ("http://www.testing123.com", "//outertag//innertag")
def scrape (url_string, tag_pattern)

  #scrapes entire HTML document and places it in a Nokogiri object (requires 'nokogiri' and 'open-uri')
  scraped_object = Nokogiri::HTML(open(url_string))

  #filters the scraped_object and stores it into a node set
  #tag_patterns are ideally specified to pull multiple items (e.g. multiple <p></p> that match the same condition) which result in an array of many items
  parsed_node_set = scraped_object.css(tag_pattern)

  # parsed_array = []
  # #converts nodeset to array of strings
  # parsed_node_set.each do |element|
  #   parsed_array << element.to_s
  # end
  #
  # parsed_array


  text_array = []
  parsed_node_set.map do |item|
    text_array.push(item)
  end

  #push the array into the csv file
  CSV.open('results.csv', 'w') do |csv|
    csv << text_array
  end


end


breakoutlist_URL = "https://breakoutlist.com/"
# puts scrape(breakoutlist_URL,"//table//tr//td")
puts scrape(breakoutlist_URL,"//table//tr")



#See this page for how to assign specific tags based on the URL: http://www.nokogiri.org/tutorials/searching_a_xml_html_document.html
#doc.css('//car:tire', 'car' => 'http://alicesautoparts.com/')
