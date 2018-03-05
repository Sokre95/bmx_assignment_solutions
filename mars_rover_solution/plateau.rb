class Plateau
  attr_reader :height, :width, :rovers

  def initialize(dimensions)
    @height, @width = dimensions
    @rovers = []
  end

  def add_rover(rover, rover_commands)
    @rovers << { rover: rover, commands: rover_commands }
  end
end