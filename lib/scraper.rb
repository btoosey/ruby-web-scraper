require 'httparty'
require 'nokogiri'
require_relative 'entry'

def scraper
  entries = []

  # Scrape website for entries
  url = 'https://news.ycombinator.com/'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page.body)

  parsed_page.css('tr.athing').each do |entry|
    subtext = entry.next_element.css('td.subtext')

    rank = extract_number(entry.css('span.rank').text)
    title = entry.css('a.titlelink').text
    score = extract_number(subtext.css('span.score').text)
    comments = extract_number(subtext.css('a').last.text)

    entry = Entry.new(rank, title, score, comments)

    entries << entry
  end

  # Display entries to user through required filters
  program_output(entries)
end

private

def program_output(entries)
  puts
  puts 'Filter 1:'
  filter_one(entries)

  puts
  puts 'Filter 2:'
  filter_two(entries)
end

def filter_one(entries)
  # 1. Select each entry if its title is more than 5 words long
  filtered_entries = more_than_five(entries)

  # 2. Order by number of comments
  order_entries(filtered_entries, 'comments').each do |entry|
    puts "#{entry.title} | #{entry.comments} Comments"
  end
end

def filter_two(entries)
  # 1. Select each entry if its title is less than or equal to 5 words long
  filtered_entries = less_or_eq_five(entries)

  # 2. Order by score
  order_entries(filtered_entries, 'score').each do |entry|
    puts "#{entry.title} | #{entry.score} Points"
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
  filtered_entries = []
  entries.each do |entry|
    filtered_entries << entry if entry.title.split.length <= 5
  end
  filtered_entries
end

def order_entries(entries, query)
  # Sort entries by either comments, or score
  case query
  when 'comments'
    entries.sort_by { |entry| entry.comments }
  when 'score'
    entries.sort_by { |entry| entry.score }
  end
end

def extract_number(text)
  # Regex expression to isolate number in string
  text[/\d+/].to_i
end

scraper
