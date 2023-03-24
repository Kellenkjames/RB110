# frozen_string_literal: true

WINNING_LINES =
  [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
  [[1, 5, 9], [3, 5, 7]] # diagonals

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, _delimeter = ',', word = 'or')
  arr.size == 1 ? arr.join('') : arr.insert(arr[-2], word)
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER} | Computer is #{COMPUTER_MARKER}"
  puts ''
  puts '     |     |'
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |'
  puts ''
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def display_prompt(brd)
  smart_prompt = joinor(empty_squares(brd))
  smart_prompt.delete_if(&:nil?) if smart_prompt.size > 1

  if smart_prompt[-1] == 'or'
    smart_prompt.delete_at(-1)
    smart_prompt.insert(-2, 'or')
  end
  smart_prompt
end

def player_turn!(brd)
  square = ''
  display_prompt(brd)

  loop do
    prompt "Choose a position to place a piece: #{[display_prompt(brd)].join(', ')}"
    square = gets.chomp.to_i

    break if empty_squares(brd).include?(square)

    prompt "Sorry, that's not a valid choice."
  end

  brd[square] = PLAYER_MARKER
end

def fill_at_risk_square(brd, square)
  brd[square] = COMPUTER_MARKER if brd[square] == INITIAL_MARKER
end

def find_at_risk_square(brd)
  WINNING_LINES.each do |line|
    line.each do |square|
      if brd.values_at(line[0], line[1], line[2]).count(COMPUTER_MARKER) == 2
        fill_at_risk_square(brd, square)
      elsif brd.values_at(line[0], line[1], line[2]).count(PLAYER_MARKER) == 2
        fill_at_risk_square(brd, square)
      end
    end
  end
end

def computer_ai_strategy(brd)
  find_at_risk_square(brd)
  brd[5] = COMPUTER_MARKER if brd[5] == INITIAL_MARKER
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def computer_turn!(brd)
  computer_ai_strategy(brd)
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    return 'Player' if brd.values_at(line[0], line[1], line[2]).count(PLAYER_MARKER) == 3
    return 'Computer' if brd.values_at(line[0], line[1], line[2]).count(COMPUTER_MARKER) == 3
  end
  nil
end

def current_player
  options = %w[P C]
  loop do
    prompt 'Who should go first 🤔 P (Player) or C (Computer)'
    player_answer = gets.chomp.upcase
    computer_answer = options.sample

    return 'Player' if player_answer || computer_answer == 'P'
    return 'Computer' if computer_answer == 'C'

    break if options.include?(player_answer)

    prompt 'Please select P (Player) or C (Computer).'
  end
end

def first_move(_brd)
  current_player
end

def place_piece!(brd, current_player)
  current_player == 'Player' ? player_turn!(brd) : computer_turn!(brd)
end

def alternate_player(current_player)
  current_player == 'Player' ? 'Computer' : 'Player'
end

def display_game_scores(player_score, computer_score)
  prompt "Player Score: #{player_score}"
  prompt "Computer Score: #{computer_score}"
  prompt 'Play Again? (y or n)'
end

player_score = 0
computer_score = 0

loop do
  board = initialize_board
  current_player = first_move(board)

  loop do
    display_board(board)
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  someone_won?(board) ? prompt("#{detect_winner(board)} Won!") : prompt("It's a Tie!")

  player_score += 1 if detect_winner(board) == 'Player'
  computer_score += 1 if detect_winner(board) == 'Computer'

  display_game_scores(player_score, computer_score)

  if player_score == 5
    prompt 'Player Wins Game 🎉 🎉 🎉 🎉 🎉'
    player_score = 0
    computer_score = 0
  elsif computer_score == 5
    prompt 'Computer Wins Game 🤖 🤖 🤖 🤖 🤖'
    player_score = 0
    computer_score = 0
  end

  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt 'Thanks for playing Tic Tac Toe! Good Bye!'
