require "./scraper"

describe 'Filter 1' do
  entries = [
    { rank: 1, title: 'Comparing Rust and JavaScript', score: 102, comments: 5 },
    { rank: 2, title: 'Kurt Vonnegut on the 8 “shapes” of stories', score: 158, comments: 20 },
    { rank: 3, title: 'EA: The Human Story', score: 53, comments: 24 },
    { rank: 4, title: 'Advice for the next dozen Rust GUIs', score: 243, comments: 212 },
    { rank: 5, title: 'Project Fear', score: 80, comments: 36 },
    { rank: 6, title: 'State of the SqueakPhone', score: 10, comments: 13 },
    { rank: 7, title: 'Ask HN: How do you use Bitcoin in a trustless way?', score: 34, comments: 26 },
    { rank: 8, title: 'Volkswagen enters battery business with $20B investment', score: 300, comments: 188 }
  ]

  filtered_entries = [
    { rank: 2, title: 'Kurt Vonnegut on the 8 “shapes” of stories', score: 158, comments: 20 },
    { rank: 4, title: 'Advice for the next dozen Rust GUIs', score: 243, comments: 212 },
    { rank: 7, title: 'Ask HN: How do you use Bitcoin in a trustless way?', score: 34, comments: 26 },
    { rank: 8, title: 'Volkswagen enters battery business with $20B investment', score: 300, comments: 188 }
  ]

  ordered_entries = [
    { rank: 2, title: 'Kurt Vonnegut on the 8 “shapes” of stories', score: 158, comments: 20 },
    { rank: 7, title: 'Ask HN: How do you use Bitcoin in a trustless way?', score: 34, comments: 26 },
    { rank: 8, title: 'Volkswagen enters battery business with $20B investment', score: 300, comments: 188 },
    { rank: 4, title: 'Advice for the next dozen Rust GUIs', score: 243, comments: 212 }
  ]

  it 'selects entries with titles of more than 5 words' do
    f = more_than_five(entries)

    expect(f).to eq(filtered_entries)
  end

  it 'orders entries by number of comments' do
    f = order_entries(filtered_entries)

    expect(f).to eq(ordered_entries)
  end
end
