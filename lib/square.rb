require_relative 'ship'

# This class represent container with cells for ships and some logic of program
class Square
  attr_reader :private_schema, :showing_schema, :lived_ships, :shots

  BLOCKED = '1'

  def initialize
    @lived_ships = []
    @shots = []
    @showing_schema = []
    @private_schema = []

    12.times do |x|
      @showing_schema[x] = Array.new(12)
      @private_schema[x] = Array.new(12)
      12.times { |y| @showing_schema[x][y] = ' . ' }
    end

    @showing_schema[0] = ['    ', ' A ', ' B ', ' C ', ' D ',
                          ' E ', ' F ', ' G ', ' H ', ' I ', ' J ']

    (1..9).each { |x| @showing_schema[x][0] = '  ' + x.to_s + ' ' }
    @showing_schema[10][0] = ' ' + 10.to_s + ' '
  end

  def spot_is_free?(crdn, ship)
    return false unless @private_schema[crdn[:x]][crdn[:y]].nil?
    if ship.deck_size2?
      if ship.vertical?
        return false unless @private_schema[crdn[:x].next][crdn[:y]].nil?
      elsif ship.horisontal?
        return false unless @private_schema[crdn[:x]][crdn[:y].next].nil?
      end
      return true
    else
      true
    end
  end

  def block_around(crdns)
    crdns.each do |crdn|
      ((crdn[:x] - 1)..(crdn[:x].next)).each do |i|
        ((crdn[:y] - 1)..(crdn[:y].next)).each do |j|
          @private_schema[i][j] = BLOCKED
        end
      end
    end
  end

  def put_ship_to_schema(ship)
    ship.coordinates.each do |crdn|
      @private_schema[crdn[:x]][crdn[:y]] = ship
    end
  end

  def put_ship(ship)
    random_coord = nil
    loop do
      random_coord = ship.random_coordinate
      break if spot_is_free?(random_coord, ship)
    end
    ship.init_coordinates(random_coord)
    coordinates = ship.coordinates
    block_around coordinates
    put_ship_to_schema ship
    @lived_ships << ship
  end

  def do_shot(crdn)
    return if @shots.include? crdn
    @shots << crdn
    ship = @private_schema[crdn[:x]][crdn[:y]]
    if ship.class == Ship
      ship.injure crdn
      @showing_schema[crdn[:x]][crdn[:y]] = ' + '
      if ship.dead?
        ship.injured_coordinates.each do |i|
          @showing_schema[i[:x]][i[:y]] = ' X '
          @private_schema[i[:x]][i[:y]] = nil
        end
        @lived_ships.delete ship
      end
    else
      @showing_schema[crdn[:x]][crdn[:y]] = ' 0 '
    end
  end
end
