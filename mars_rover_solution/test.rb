load './mars_mission.rb'

m = MarsRoverMission.new(2)
m.init
m.start_rovers
m.print_final_positions