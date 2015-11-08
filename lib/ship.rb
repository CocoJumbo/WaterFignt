# This class represent the Ship which is located to square
class Ship
  attr_reader :coordinates, :injured_coordinates

  def initialize(count)
    @count_decks = count
    @orientation = rand 2 if @count_decks > 1
    @coordinates = []
    @injured_coordinates = []
  end

  def vertical?
    @orientation == 1
  end

  def horisontal?
    @orientation == 0
  end

  def deck_size2?
    @count_decks == 2
  end

  def injure(coordinate)
    @coordinates.delete coordinate
    @injured_coordinates << coordinate
  end

  def dead?
    @coordinates.empty?
  end

  def init_coordinates(start_coordinate)
    return unless coordinates.empty?
    @coordinates << start_coordinate
    if vertical?
      @coordinates << { x: start_coordinate[:x].next, y: start_coordinate[:y] }
    elsif horisontal?
      @coordinates << { x: start_coordinate[:x], y: start_coordinate[:y].next }
    end
  end

  def random_coordinate
    if deck_size2?
      if vertical?
        { x: rand(1..9), y: rand(1..10) }
      elsif horisontal?
        { x: rand(1..10), y: rand(1..8) }
      end
    else
      { x: rand(1..8), y: rand(1..10) }
    end
  end
end
