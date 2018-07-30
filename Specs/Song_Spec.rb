require("minitest/autorun")
require_relative("../Song")

class SongTest < MiniTest::Test

def setup
  @song1 = Song.new("Taylor Swift", "Red")
end

  def test_song_has_name
    assert_equal("Red", @song1.track_name)
  end

  def test_song_has_artist
    assert_equal("Taylor Swift", @song1.artist)
  end

end
