require_relative 'lib/ship'
require_relative 'lib/square'
require_relative 'lib/dialog'

square = Square.new

4.times do
  square.put_ship Ship.new 1
end
3.times do
  square.put_ship Ship.new 2
end

dialog = Dialog.new(square)

loop do
  Dialog.clear_terminal
  dialog.show_schema do |out_case|
    puts
    puts 'S ship | + injured | 0 miss | X dead ship'
    puts
    puts case out_case
           when Dialog::ALREADY_WAS
             'You\'ve already entered, try again:'
           when Dialog::SURRENDER
             'What a shame... Insert value:'
           when Dialog::ERROR
             'Again, enter correct value:'
           else
             'Insert value:'
         end
  end
  break if square.lived_ships.empty?
  dialog.listen_shot
end

puts 'YOU WIN!'
