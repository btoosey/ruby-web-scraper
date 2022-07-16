require './lib/scraper'

describe 'Filter 1' do
  entries = [
    Entry.new(1, 'Comparing Rust and JavaScript', 102, 5),
    Entry.new(2, 'Kurt Vonnegut on the 8 “shapes” of stories', 158, 20),
    Entry.new(3, 'EA: The Human Story', 53, 24),
    Entry.new(4, 'Advice for the next dozen Rust GUIs', 243, 212),
    Entry.new(5, 'Project Fear', 80, 36),
    Entry.new(6, 'State of the SqueakPhone', 10, 13),
    Entry.new(7, 'Ask HN: How do you use Bitcoin in a trustless way?', 34, 26),
    Entry.new(8, 'Volkswagen enters battery business with $20B investment', 300, 188)
  ]

  filtered_entries = [
    entries[1],
    entries[3],
    entries[6],
    entries[7]
  ]

  ordered_entries = [
    entries[1],
    entries[6],
    entries[7],
    entries[3]
  ]

  it 'selects entries with titles of more than 5 words' do
    f = more_than_five(entries)
    expect(f).to eq(filtered_entries)
  end

  it 'orders entries by number of comments' do
    f = order_entries(filtered_entries, 'comments')
    expect(f).to eq(ordered_entries)
  end
end
