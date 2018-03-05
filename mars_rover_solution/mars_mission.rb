load './plateau.rb'
load './rover.rb'

class MarsRoverMission

  def initialize(rovers_count)
    @rovers_count = rovers_count
  end

  def init
    @plateau = create_plateua
    @rovers_count.times do
      new_rover = Rover.new(ARGF.gets.strip.split(' '), @plateau)
      new_commands = ARGF.gets.strip
      @plateau.add_rover(new_rover, new_commands)
    end
  end

  def start_rovers
    @plateau.rovers.each do |rc|
      rc[:commands].each_char do |command|
        rc[:rover].execute(command)
      end
    end
  end

  def print_final_positions
    puts
    @plateau.rovers.each {|r| puts r[:rover].to_s}
  end

  private

  def create_plateua
    plateau_dimensions = ARGF.gets.strip.split(' ').map(&:to_i)
    Plateau.new(plateau_dimensions)
  end
end