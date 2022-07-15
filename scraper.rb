require 'httparty'
require 'nokogiri'
require 'byebug'
require_relative 'entry'

def scraper
  url = 'https://news.ycombinator.com/'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  entries = []

  parsed_page.css('tr.athing').each do |entry|
    subtext = entry.next_element.css('td.subtext')

    rank = extract_number(entry.css('span.rank').text)
    title = entry.css('a.titlelink').text
    score = extract_number(subtext.css('span.score').text)
    comments = extract_number(subtext.css('a').last.text)

    entry = Entry.new(rank, title, score, comments)

    entries << entry
  end
end

private

def extract_number(text)
  # Regex expression to isolate number in string
  text[/\d+/].to_i
end

scraper
