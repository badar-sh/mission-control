class Mission
  attr_reader :name, :random_seed

  def initialize(mission_control)
    @mission_control = mission_control

    get_name

    puts "Would you like to proceed? (Y/n)"
    answer = gets.chomp.downcase

    exit unless answer == 'y'

    @random_seed = 12
    srand(@random_seed)
  end

  def get_name
    puts "\nMission plan:"
    puts "  Travel distance: 160.0 km"
    puts "  Payload capacity: 50,000 kg"
    puts "  Fuel capacity: 1,514,100 liters"
    puts "  Burn rate: 168,240 liters/min"
    puts "  Average speed: 1,500 km/h"
    puts "  Random seed: 12"

    puts "What is the name of this mission?"
    @name = gets.chomp
  end

  def process_answer
    answer = gets.chomp.downcase

    abort_mission("Mission aborted!") unless answer == 'y'
  end

  def start
    puts "\nEngage afterburner? (Y/n)"
    process_answer

    puts "Afterburner engaged!"

    puts "\nRelease support structures? (Y/n)"
    process_answer

    puts "Support structures released!"

    puts "\nPerform cross-checks? (Y/n)"
    process_answer

    puts "Cross-checks performed!"

    puts "\nLaunch? (Y/n)"
    answer = gets.chomp.downcase

    if answer == 'y'
      puts "Launched!"

      travel_distance = 0.0
      fuel_burn_rate = 168_240
      speed = 1_500
      elapsed_time = 0
      time_to_destination = 6 * 60

      while travel_distance < 160.0 && elapsed_time < time_to_destination
        puts "\nMission status:"
        puts "  Current fuel burn rate: #{fuel_burn_rate} liters/min"
        puts "  Current speed: #{speed} km/h"
        puts "  Current distance traveled: #{travel_distance.round(2)} km"
        puts "  Elapsed time: #{format_time(elapsed_time)}"
        puts "  Time to destination: #{format_time(time_to_destination - elapsed_time)}"

        sleep(1) # Simulate time passing

        elapsed_time += 1
        travel_distance += (speed.to_f / 60)

        if elapsed_time % 30 == 0
          fuel_burn_rate -= (fuel_burn_rate * 0.1).to_i
          speed -= (speed * 0.1).to_i
        end

        if elapsed_time % 60 == 0
          @mission_control.total_fuel_burned += fuel_burn_rate
          @mission_control.total_flight_time += elapsed_time
        end

        if elapsed_time % 300 == 0 && rand(1..3) == 1
          abort_mission("Mission aborted! Randomized abort and retry.")
          return
        end

        if elapsed_time % 300 == 0 && rand(1..5) == 1
          puts "\nMission exploded! Randomized explosion."
          @mission_control.explosions += 1
          return
        end
      end

      if travel_distance >= 160.0
        puts "\nMission completed!"

        @mission_control.total_distance += travel_distance
      else
        abort_mission("Mission aborted!")
      end
    else
      abort_mission("Mission aborted!")
    end
  end

  private

  def abort_mission(message)
    puts "\n#{message}"

    @mission_control.abort_retries += 1
  end

  def format_time(time)
    minutes = time % 60
    hours = (time / 60) % 24
    seconds = time % 60

    format('%02d:%02d:%02d', hours, minutes, seconds)
  end
end
