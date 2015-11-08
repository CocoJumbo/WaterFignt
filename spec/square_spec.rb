require 'rspec'
require '../lib/square.rb'
require '../lib/ship.rb'

describe Square do

  describe '.spot_is_free?' do
    subject { Square.new }
    it 'Return true if spot is free from concrete coordinate in private
        schema, if spot is occuped or blocked, return false' do
      ship = Ship.new(1)
      expect(subject.spot_is_free?({ x: 1, y: 1 }, ship)).to eql(true)
      subject.private_schema[1][1] = ship
      expect(subject.spot_is_free?({ x: 1, y: 1 }, ship)).to eql(false)
      subject.private_schema[1][1] = Square::BLOCKED
      expect(subject.spot_is_free?({ x: 1, y: 1 }, ship)).to eql(false)
    end

    ship = Ship.new(2)

    it 'Return false if ship size is 2, horisontal orientation and spot from
        right occupied or blocked, or true if free' do
      allow(ship).to receive(:horisontal?).and_return(true)
      allow(ship).to receive(:vertical?).and_return(false)
      allow(ship).to receive(:deck_size2?).and_return(true)

      expect(subject.spot_is_free?({ x: 1, y: 3 }, ship)).to eql(true)
      subject.private_schema[1][4] = ship
      expect(subject.spot_is_free?({ x: 1, y: 3 }, ship)).to eql(false)
      subject.private_schema[1][4] = Square::BLOCKED
      expect(subject.spot_is_free?({ x: 1, y: 3 }, ship)).to eql(false)
    end

    it 'Similar of previous test but
        ship is vertical and check bottom spot' do
      allow(ship).to receive(:horisontal?).and_return(false)
      allow(ship).to receive(:vertical?).and_return(true)

      expect(subject.spot_is_free?({ x: 1, y: 3 }, ship)).to eql(true)
      subject.private_schema[2][3] = ship
      expect(subject.spot_is_free?({ x: 1, y: 3 }, ship)).to eql(false)
      subject.private_schema[2][3] = Square::BLOCKED
      expect(subject.spot_is_free?({ x: 1, y: 3 }, ship)).to eql(false)
    end
  end

  describe '.block_around' do
    it 'Blocking cells in specified area' do
      subject { Square.new }
      subject.block_around([{ x: 1, y: 1 }])
      (0..2).each do |i|
        (0..2).each do |j|
          expect(subject.private_schema[i][j]).to eql(Square::BLOCKED)
        end
      end
      subject.block_around([{ x: 3, y: 4 }, { x: 3, y: 5 }])
      (2..4).each do |i|
        (3..6).each do |j|
          expect(subject.private_schema[i][j]).to eql(Square::BLOCKED)
        end
      end
    end
  end

  describe '.put_ship_to_schema' do
    subject { Square.new }
    it 'Put links of ship to private_scheme' do
      ship = Ship.new(1)
      ship.init_coordinates(({ x: 1, y: 1 }))
      subject.put_ship_to_schema ship
      expect(subject.private_schema[1][1]).to eql ship
    end
  end
  describe '.do_shot' do
    # do not attention please to this, i think how write it correct
=begin
    subject { Square.new }
    before do
      ship = Ship.new(2)
      allow(ship).to receive(:horisontal?).and_return(true)
      allow(ship).to receive(:vertical?).and_return(false)
      coordinate_11 = { x: 1, y: 1 }
      ship.init_coordinates(coordinate_11)
      subject.put_ship ship
      subject.do_shot(coordinate_11)
    end
    it 'Injure ship if it size is 2' do
      expect(ship.is_dead?).to eql false
    end
    it 'To mark a cell of showing_schema +' do
      expect(subject.showing_schema[coordinate_11[:x]][coordinate_11[:y]]).to eql '+'
    end
=end
  end
end