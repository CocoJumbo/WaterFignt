require 'rspec'
require '../lib/ship.rb'

describe Ship do
  describe '.random_coordinate' do
    it 'Return random start coordinate' do
      200.times do
        ship = Ship.new rand(1..2)
        coordinate = ship.random_coordinate
        expect(true).to eq(coordinate[:x] >= 1 && coordinate[:x] <= 10)
        expect(true).to eq(coordinate[:y] >= 1 && coordinate[:y] <= 10)
        next unless ship.deck_size2?
        if ship.horisontal?
          expect(true).to eq(coordinate[:y] <= 9)
        elsif ship.vertical?
          expect(true).to eq(coordinate[:x] <= 9)
        end
      end
    end
  end

  describe '.init_coordinates' do
    it 'Get 1 start coordinate and put it to
        coordinates array if ship size is 1' do
      # subject { Ship.new(1) }
      # out err >> wrong number of arguments (0 for 1)
      # what's wrong?
      ship = Ship.new 1
      ship.init_coordinates(({ x: 1, y: 1 }))
      expect(ship.coordinates).to eql [{ x: 1, y: 1 }]
    end
    it 'Get 1 start coordinate, put it, and 2-th coordinate
        with offset to right if orientation is horisontal' do
      ship = Ship.new 2
      allow(ship).to receive(:horisontal?).and_return(true)
      allow(ship).to receive(:vertical?).and_return(false)
      ship.init_coordinates(({ x: 1, y: 1 }))
      expect(ship.coordinates).to eql [{ x: 1, y: 1 },
                                       { x: 1, y: 2 }]
    end
    it 'Similar of previous test but position
        is vertical, offset to bottom' do
      ship = Ship.new 2
      allow(ship).to receive(:horisontal?).and_return(false)
      allow(ship).to receive(:vertical?).and_return(true)
      ship.init_coordinates(({ x: 1, y: 1 }))
      expect(ship.coordinates).to eql [({ x: 1, y: 1 }),
                                       ({ x: 2, y: 1 })]
    end
  end

  describe '.injure' do
    it 'Delete hash coordinate from coordinates
        and put it to injured_coordinates' do
      ship = Ship.new 2
      allow(ship).to receive(:horisontal?).and_return(false)
      allow(ship).to receive(:vertical?).and_return(true)
      ship.init_coordinates(({ x: 1, y: 1 }))
      ship.injure(({ x: 1, y: 1 }))
      expect(ship.injured_coordinates).to eql([{ x: 1, y: 1 }])
      expect(ship.coordinates).to eql([{ x: 2, y: 1 }])
    end
  end
end
