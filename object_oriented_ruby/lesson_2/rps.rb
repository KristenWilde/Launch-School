# In RPS, 2 players simultaneously display one of 3 options as a move:
# rock, paper, or scissors. One of them wins according to a pre-determined formula.

# Nouns : players, move, rule
# Verbs : choose/display, compare

class Player
  attr_accessor :move, :name
  
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = ""
      loop do
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "Sorry, must enter a value."
      end
      self.name = n
    else
      self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include? choice
        puts "Sorry, invalid choice."
      end
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissors'].sample
    end
  end
  
  def human?
    @player_type == :human
  end
end


# Game orchestration engine:
class RPSGame 
  attr_accessor :human, :computer
  
  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end
  
  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end
  
  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    case human.move
      when 'rock'
        puts "It's a tie!" if computer.move == 'rock'
        puts "#{human.name} won!" if computer.move == 'scissors'
        puts "#{computer.name} won!" if computer.move == 'paper'
      when 'paper'
        puts "It's a tie!" if computer.move == 'paper'
        puts "#{human.name} won!" if computer.move == 'rock'
        puts "#{computer.name} won!" if computer.move == 'scissors'
      when 'scissors'
        puts "It's a tie!" if computer.move == 'scissors'
        puts "#{human.name} won!" if computer.move == 'paper'
        puts "#{computer.name} won!" if computer.move == 'rock'
    end
  end
  
  def play_again?
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      if answer == 'y' then break true
      elsif answer == 'n' then break false
      end
      puts "Sorry, must be y or n."
    end
  end
  
  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!"
  end
end

RPSGame.new.play