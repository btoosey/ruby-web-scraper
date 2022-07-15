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
      rank: extract_number(entry.css('span.rank').text),
      title: entry.css('a.titlelink').text,
      score: extract_number(subtext.css('span.score').text),
      comments: extract_number(subtext.css('a').last.text)
    }

    puts entry
  end
end

def extract_number(text)
  # Regex expression to isolate number in string
  text[/[0-9]/].to_i
end

scraper
