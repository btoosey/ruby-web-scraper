require 'httparty'
require 'nokogiri'
require 'byebug'

def scraper
  url = 'https://news.ycombinator.com/'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  parsed_page.css('tr.athing').each do |entry|
    subtext = entry.next_element.css('td.subtext')
    entry = {
      rank: entry.css('span.rank').text,
      title: entry.css('a.titlelink').text,
      score: subtext.css('span.score').text,
      comments: subtext.css('a').last.text
    }

    puts entry
  end
end

scraper
