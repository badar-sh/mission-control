require './mission'

class MissionControl
  attr_accessor :total_distance, :abort_retries, :explosions, :total_fuel_burned, :total_flight_time

  def initialize
    @total_distance = 0.0
    @abort_retries = 0
    @explosions = 0
    @total_fuel_burned = 0
    @total_flight_time = 0
  end

  def run
    puts "Welcome to Mission Control!"

    loop do
      mission = Mission.new(self)
      mission.start

      puts "\nMission summary:"
      puts "  Total distance traveled: #{@total_distance} km"
      puts "  Number of abort and retries: #{@abort_retries}"
      puts "  Number of explosions: #{@explosions}"
      puts "  Total fuel burned: #{@total_fuel_burned} liters"
      puts "  Total flight time: #{@total_flight_time}\n"

      puts "Would you like to run another mission? (Y/n)"
      answer = gets.chomp.downcase
      break if answer == 'n'
    end
  end
end

mission_control = MissionControl.new
mission_control.run
