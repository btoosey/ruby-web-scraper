require "./lib/scraper"

describe 'Filter 2' do
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
    entries[0],
    entries[2],
    entries[4],
    entries[5]
  ]

  ordered_entries = [
    entries[5],
    entries[2],
    entries[4],
    entries[0]
  ]

  it 'selects entries with titles of less than or equal to 5 words' do
    f = less_or_eq_five(entries)
    expect(f).to eq(filtered_entries)
  end

  it 'orders entries by score' do
    f = order_entries_score(filtered_entries)
    expect(f).to eq(ordered_entries)
  end
end
