require("minitest/autorun")
require_relative("../Guest")
require_relative("../Song")

class GuestTest < MiniTest::Test


  def setup
    @song1 = Song.new("Taylor Swift", "Red")
    @guest1 = Guest.new("Connie", 100, @song1)
  end

  def test_guest_has_name
    assert_equal("Connie", @guest1.name)
  end

  def test_guest_has_wallet
    assert_equal(100, @guest1.wallet)
  end

  def test_guest_has_fav_song
    assert_equal("Red", @guest1.fav_song.track_name)
  end

  def test_check_fav_song
    result = @guest1.check_fav_song(@song1)
    assert_equal("Woop! Woop!", result)
  end


end
