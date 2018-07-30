class Room

  attr_reader :room_name, :cost_per_person, :capacity, :guests_in_room, :money_of_room

  def initialize(room_name, cost_per_person, capacity, stored_songs)
    @room_name = room_name
    @cost_per_person = cost_per_person
    @capacity = capacity
    @stored_songs = stored_songs
    @currently_playing = nil
    @guests_in_room = []
    @money_of_room = 0
  end

  def choose_song_by_name(song_title)
    result =  @stored_songs.select { |song| song.track_name == song_title }.first
    if result != nil
      @currently_playing = result
      guest_fav_song_plays()
      return @currently_playing
    end
  end

  def choose_random_song_by_artist(artist)
    result = @stored_songs.select { |song| song.artist == artist}.sample
    if result != nil
      @currently_playing = result
      guest_fav_song_plays()
      return @currently_playing
    end
  end


  def guests_enter_room(guest)
    if @guests_in_room.length < @capacity && guest.wallet >= cost_per_person
      @guests_in_room.push(guest)
      guest.remove_money(@cost_per_person)
      @money_of_room += @cost_per_person
    elsif @guests_in_room.length >= @capacity
      return "room is at capacity"
    elsif guest.wallet < cost_per_person
      return "insufficient funds to enter room"
    end
  end

  def guest_leaves_room(guest)
    @guests_in_room.delete(guest)
  end

  def guest_fav_song_plays()
    for guest in @guests_in_room
      guest.check_fav_song(@currently_playing)
    end
  end

  def play_random_song()
    @currently_playing = @stored_songs.sample
    guest_fav_song_plays()
    return @currently_playing
  end


end
