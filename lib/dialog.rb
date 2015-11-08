require 'os'

# Class, which print and read information from console
class Dialog
  def initialize(square)
    @square = square
    @assotiation_of = { 'A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5,
                        'F' => 6, 'G' => 7, 'H' => 8, 'I' => 9, 'J' => 10 }
  end

  ALREADY_WAS = 1
  SURRENDER = 2
  ERROR = 3

  def parse_coordinate(input_text)
    fail 'invalid input' unless input_text =~ /^[A-J]([1-9]|10)$/
    x = (input_text.slice /\d{1,2}/).to_i
    y = input_text.slice /[A-J]/
    y = (@assotiation_of[y]).to_i
    { x: x, y: y }
  end

  def self.clear_terminal
    system OS.windows? ? 'cls' : 'clear'
  end

  def listen_shot
    reset_out_case
    begin
      input = gets
      coordinate = parse_coordinate input
      if @square.shots.include? coordinate
        @out_case = ALREADY_WAS
        return
      end
      @square.do_shot coordinate
    rescue
      if input =~ /^surrender$/
        @out_case = SURRENDER
      else
        @out_case = ERROR
      end
    end
  end

  def reset_out_case
    @out_case = nil
  end

  def show_schema
    11.times do |x|
      11.times do |y|
        sh_cell = @square.showing_schema[x][y]
        sh_cell = ' S ' if @out_case == SURRENDER &&
                           @square.private_schema[x][y].class == Ship
        print sh_cell
      end
      puts
    end
    yield(@out_case)
  end
end
