
class Move
  def to_s
    self.class.to_s
  end
  
  def >(other)
    opponent = other.class.to_s
    self.class::DEFEATS.keys.include?(opponent)
  end
end

class Rock < Move
  DEFEATS = {'Scissors' => 'crushes', 'Lizard' => 'crushes'}
end

class Paper < Move
  DEFEATS = {'Rock' => 'covers', 'Spock' => 'disproves'}
end

class Scissors < Move
  DEFEATS = {'Paper' => 'cut', 'Lizard' => 'decapitate'}
end

class Lizard < Move
  DEFEATS = {'Paper' => 'eats','Spock' => 'poisons'}
end

class Spock < Move
  DEFEATS = {'Scissors' => 'smashes', 'Rock' => 'vaporizes'}
end

# human or computer
class Player
  attr_accessor :move, :name, :score
  MOVES = { r: Rock.new,
            p: Paper.new,
            s: Scissors.new,
            l: Lizard.new,
            sp: Spock.new,
            q: false }.freeze
            

  def initialize
    set_name
    @score = 0
  end
  
  def to_s
    name
  end
end

# for the human player
class Human < Player
  
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts 'Sorry, must enter a value.'
    end
    self.name = n
  end

  def choose_move
    choice = nil
    loop do
      puts "Choose (r)ock, (p)aper, (s)cissors, (l)izard (sp)ock, or (q)uit:"
      choice = gets.chomp.downcase.to_sym
      break if MOVES.keys.include? choice
      puts 'Sorry, invalid choice.'
    end
    self.move = MOVES[choice]
  end


end

# for the computer player
class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose_move
    self.move = MOVES[[:r, :p, :s, :l, :sp].sample]
  end
end

class Round
  
end

# Game orchestration engine:
class RPSGame
  WIN = 4
  GAME_NAME = "Rock Paper Scissors Lizard Spock".freeze
  attr_accessor :human, :computer, :round_num


  def initialize
    @history = []
    @round_num = 1
  end

  def play
    clear_screen
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    loop do
      puts
      break unless human.choose_move
      computer.choose_move
      winner = calculate_winner
      comment_on_points
      save_round(winner)
      clear_screen
      display_welcome_message
      display_score
      puts
      display_history
      puts
      # break unless play_again?
    end
    display_goodbye_message
  end

  def clear_screen
    system('clear') || system('cls')
  end

  def display_welcome_message
    puts "Welcome to #{GAME_NAME}!"
  end

  # def display_moves
  #   puts "#{human.name} chose #{human.move}."
  #   puts "#{computer.name} chose #{computer.move}."
  # end

  def calculate_winner
    if human.move > computer.move
      human.score += 1
      human
    elsif computer.move > human.move
      computer.score += 1
      computer
    else
      'tie'
    end
  end
  
  # def display_winner(winner)
  #   if winner == 'tie' 
  #     puts "It's a tie!"
  #   else
  #     puts "#{winner} won!"
  #   end
  # end

  def display_score
    puts "First player to #{WIN} points wins.      " \
         "#{human.name}: #{human.score}     " \
         "#{computer.name}: #{computer.score}"
  end

  def save_round(winner)
    if winner == 'tie'
      round = { number: round_num,
                winner: winner,
                moves: human.move
      }
    else
      loser = ([human, computer] - [winner]).first
      verb = winner.move.class::DEFEATS[loser.move.to_s]
      round = { number: round_num,
                winner: winner.name,
                win_move: winner.move,
                loser: loser.name,
                lose_move: loser.move,
                verb: verb
      }
    end
    @history.push(round)
    @round_num += 1
  end

  def display_history 
    @history.each do |round| # history is an array of hashes
      if round[:winner] == 'tie'
        puts "Round #{round[:number]}: " \
             "Tie. Both chose #{round[:moves]}."
      else
        puts "Round #{round[:number]}: " \
              "#{round[:winner]}'s #{round[:win_move]} #{round[:verb]} " \
              "#{round[:loser]}'s #{round[:lose_move]}."
      end
    end
  end

  def comment_on_points
    if (human.score == WIN) && (computer.score < WIN)
      celebrate
      reset_scores
    elsif (human.score < WIN) && (computer.score == WIN)
      puts "#{computer.name} is the first player to #{WIN} points!!"
      reset_scores
    end
  end

  def celebrate
    puts "Please press Enter."
    gets
    clear_screen
    puts "Congratulations #{human.name}, you beat #{computer.name} at " \
         "#{GAME_NAME}!"
    puts <<'FISTBUMP'
          .--.___.----.___.--._
         /|  |   |    |   |  | `--.
        /                          `.
       |                             |
       |  `    |  `     |    ` |     |
       |    `  |      ` |      |   ` |
      '|  `    | ` ` `  |  ` ` |  `  |
      ||  `    |  `     | `    |  `  |
      ||    `  |   ` `  |    ` | `  `|
      || `     | `      | ` `  |  `  |
      ||  ___  |  ____  |  __  |  _  |
      | \_____/ \______/ \____/ \___/
      |         .--.\
      |        '     |
      `.      |  _.-'
        `.|__.-'
FISTBUMP
    puts "Please press Enter."
    gets
    clear_screen
  end

  def reset_scores
    human.score = 0
    computer.score = 0
    @history = []
    puts "Scores have been reset to 0."
  end

  def play_again?
    loop do
      puts 'Keep playing? (y/n)'
      answer = gets.chomp.downcase
      break true if answer == 'y'
      break false if answer == 'n'
      puts 'Sorry, must be y or n.'
    end
  end

  def display_goodbye_message
    puts "Thanks for playing #{GAME_NAME}!"
  end
end

RPSGame.new.play


