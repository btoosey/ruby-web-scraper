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

  puts 'Filter 1'
  filter_one(entries)
end

private

def filter_one(entries)
  filtered_entries = more_than_five(entries)
  ordered_entries = order_entries(filtered_entries)
  ordered_entries.each do |entry|
    puts "#{entry.title} | #{entry.comments} Comments"
  end
end

def more_than_five(entries)
  filtered_entries = []
  entries.each do |entry|
    filtered_entries << entry if entry.title.split.length > 5
  end
  filtered_entries
end

def less_or_eq_five(entries)
end

def order_entries(entries)
  entries.sort_by { |entry| entry.comments }
end

def extract_number(text)
  # Regex expression to isolate number in string
  text[/\d+/].to_i
end

scraper
