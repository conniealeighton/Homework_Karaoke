require("minitest/autorun")
require_relative("../Song")
require_relative("../Guest")
require_relative("../Room")

class RoomTest < MiniTest::Test

  def setup
    @song1 = Song.new("Taylor Swift", "Red")
    @song2 = Song.new("Elliot Smith", "Say Yes")
    @song3 = Song.new("Iron Maiden", "Run to the Hills")
    @song4 = Song.new("Britney Spears", "Hit Me Baby One More Time")
    @song5 = Song.new("Nine Inch Nails", "Hurt")
    @song5 = Song.new("Taylor Swift", "Trouble")
    @guest1 = Guest.new("Connie", 100, @song1)
    @guest2 = Guest.new("Lucy", 25, @song4)
    @song_library = [@song1, @song2, @song3, @song4, @song5]
    @room1 = Room.new("Rainbow Room", 10, 50, @song_library)


  end

  def test_room_has_name
    assert_equal("Rainbow Room", @room1.room_name)
  end

  def test_room_has_cost
    assert_equal(10, @room1.cost_per_person)
  end

  def test_room_has_capacity
    assert_equal(50, @room1.capacity)
  end

  def test_choose_song_by_name
    result = @room1.choose_song_by_name("Red")
    assert_equal(@song1, result)
  end

  def test_set_chosen_song_to_play
    result = @room1.choose_song_by_name("Say Yes")
    assert_equal(@song2, result)
  end

  def test_guests_in_room
    @room1.guests_enter_room(@guest1)
    assert_equal(1, @room1.guests_in_room.length)
  end

  def test_guest_leaves_room
    @room1.guests_enter_room(@guest1)
    @room1.guest_leaves_room(@guest1)
    assert_equal(0, @room1.guests_in_room.length)
  end

  def test_excess_capacity
    @room2 = Room.new("Sunny Room", 10, 1, [@song1])
    @room2.guests_enter_room(@guest1)
    result = @room2.guests_enter_room(@guest2)
    assert_equal("room is at capacity", result)
  end


  def test_guest_pays_entry_insufficent_funds
    @guest3 = Guest.new("Kate", 9, @song1)
    result = @room1.guests_enter_room(@guest3)
    assert_equal("insufficient funds to enter room", result)
  end

  def test_money_moving
    @guest3 = Guest.new("Kate", 11, @song1)
    @room1.guests_enter_room(@guest3)
    assert_equal(1, @guest3.wallet)
    assert_equal(10, @room1.money_of_room)
  end


  # Unsure how to test

  # def test_fav_song_plays
  #   @room1.choose_song_by_name("Red")
  #    result = @room1.guest_fav_song_plays()
  #   assert_equal("Woop! Woop!", result)
  # end

  def test_play_random_song
  result = @room1.play_random_song
    assert_equal(true, @song_library.include?(result))
  end

  def test_play_random_song_by_artist
    result = @room1.choose_random_song_by_artist("Taylor Swift")
    assert_equal(true, [@song1, @song5].include?(result))
  end

end
