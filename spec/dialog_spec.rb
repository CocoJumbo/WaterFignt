require 'rspec'
require '../lib/dialog.rb'

describe Dialog do
  describe '.parse_coordinate' do
    subject { Dialog.new(Square.new) }
    it 'Throw error if input not match to template' do
      expect { subject.parse_coordinate('I11') }.to raise_error 'invalid input'
    end

    it 'Get text and return the corresponding coordinate' do
      expect(subject.parse_coordinate('B1')).to eql(({ x: 1, y: 2 }))
    end
  end
end
