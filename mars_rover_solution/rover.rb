class Rover

  def initialize(position, plateau)
    @x_position = position[0].to_i
    @y_position = position[1].to_i
    @direction = position[2]
    @y_max = plateau.height
    @x_max = plateau.width
  end

  def execute(command)
    case command
    when 'L' then
      turn_left
    when 'R' then
      turn_right
    when 'M' then
      move
      else
      puts "Illegal rover command #{command}"
    end
  end

  def to_s
    "#{@x_position} #{@y_position} #{@direction}"
  end

  private

  DIRECTIONS = ['N', 'E', 'S', 'W']

  def turn_left
    @direction = DIRECTIONS[(DIRECTIONS.find_index(@direction) - 1) % 4]
  end

  def turn_right
    @direction = DIRECTIONS[(DIRECTIONS.find_index(@direction) + 1) % 4]
  end

  def move
    old_x = @x_position
    old_y = @y_position
    case @direction
    when 'N'
      @y_position += 1
    when 'E'
      @x_position += 1
    when 'S'
      @y_position -= 1
    when 'W'
      @x_position -= 1
    end
    unless position_allowed?
      @x_position = old_x
      @y_position = old_y
    end
  end

  def position_allowed?
    return false if @x_position < 0 || @x_position > @x_max
    return false if @y_position < 0 || @y_position > @y_max
    true
  end
end