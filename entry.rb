class Entry
  attr_reader :title, :score, :comments

  def initialize(rank, title, score, comments)
    @rank = rank
    @title = title
    @score = score
    @comments = comments
  end
end
