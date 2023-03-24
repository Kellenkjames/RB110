# frozen_string_literal: true

CARDS = [
  %w[C A], %w[D A], %w[H A], %w[S A],
  %w[C 2], %w[D 2], %w[H 2], %w[S 2],
  %w[C 3], %w[D 3], %w[H 3], %w[S 3],
  %w[C 4], %w[D 4], %w[H 4], %w[S 4],
  %w[C 5], %w[D 5], %w[H 5], %w[S 5],
  %w[C 6], %w[D 6], %w[H 6], %w[S 6],
  %w[C 7], %w[D 7], %w[H 7], %w[S 7],
  %w[C 8], %w[D 8], %w[H 8], %w[S 8],
  %w[C 9], %w[D 9], %w[H 9], %w[S 9],
  %w[C 10], %w[D 10], %w[H 10], %w[S 10],
  %w[C J], %w[D J], %w[H J], %w[S J],
  %w[C Q], %w[D Q], %w[H Q], %w[S Q],
  %w[C K], %w[D K], %w[H K], %w[S K]
].freeze

def shuffle(cards)
  cards.map { |card| card[1] }.sample(2)
end

BUST = 21
DEALER_MAX = 17

player_stay = 0
dealer_stay = 0

dealer_score = 0
player_score = 0

player_cards = shuffle(CARDS)
dealer_cards = shuffle(CARDS)

def prompt(msg)
  puts "=> #{msg}"
end

def calc_sum(value)
  if value == 'A'
    11
  elsif value == 'and'
    0
  elsif value.to_i.zero? # J, Q, K
    10
  else
    value.to_i
  end
end

# Calculating Aces
def total(cards)
  # cards = [['H', '3'], ['S', 'Q'], ... ]
  values = cards.map { |card| card }

  sum = 0
  values.each do |value|
    sum += calc_sum(value)
  end

  # correct for Aces
  values.select { |value| value == 'A' }.count.times do
    sum -= 10 if sum > BUST
  end

  sum
end

def handle_join!(cards, word = 'and')
  if cards.size == 2
    cards.insert(-2, word).join(' ')
  elsif cards.size > 2
    values = cards.insert(-2, word).join(', ')
    values.slice!((values.index(word) + 3)) # removes trailing delimeter after "and", i.e., "2, 10, and Ace"
    values
  end
end

# rubocop:disable Metrics/ParameterLists
def initialize_game(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  prompt 'Welcome to Twenty-One! 🃏 ♣ ♠️ ♦ ♥️'
  show_dealer(dealer_cards)
  show_player(player_cards)
  player_turn(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
end
# rubocop:enable Metrics/ParameterLists

def show_dealer(dealer_cards)
  prompt "Dealer has: #{dealer_cards[0]} and ?"
end

def show_player(player_cards)
  player_total = total(player_cards)
  prompt "You have: #{player_cards[0]} and #{player_cards[1]} | Total: #{player_total}"
end

def player_hits(player_cards)
  prompt 'You chose to hit!'
  values = CARDS.map { |card| card[1] }
  player_cards << values.sample(1).join(' ')
  player_cards.delete('and')
  player_total = total(player_cards)
  prompt "Your cards are now: #{handle_join!(player_cards)} | Total: #{player_total}"
end

def player_bust?(player_cards)
  player_total = total(player_cards)
  true if player_total > BUST
end

def dealer_hits(dealer_cards)
  prompt 'Dealer hits...'
  prompt "Dealer's cards are now: #{handle_join!(dealer_cards)}"
  prompt '==========================='
end

# rubocop:disable Metrics/ParameterLists
def dealer_turn(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  values = CARDS.map { |card| card[1] }
  dealer_total = total(dealer_cards)

  loop do
    break if dealer_total >= DEALER_MAX

    dealer_cards << values.sample(1).join(' ')
    dealer_cards.delete('and')
    dealer_total = total(dealer_cards)
    dealer_hits(dealer_cards)
  end

  dealer_bust?(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
end
# rubocop:enable Metrics/ParameterLists

def dealer_wins(player_cards, dealer_cards, dealer_score, player_score)
  prompt 'Player busts ❌'
  prompt '==========================='
  end_of_round(player_cards, dealer_cards)
  prompt 'Dealer wins!'
  dealer_score += 1
  show_game_score(dealer_score, player_score)
  game_winner?(dealer_score, player_score)
  prompt '==========================='
  dealer_score = 0 && player_score = 0 if dealer_score == 5 || player_score == 5
  play_again?(dealer_score, player_score)
end

# rubocop:disable Metrics/ParameterLists
def player_wins?(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  player_total = total(player_cards)

  if player_bust?(player_cards)
    dealer_wins(player_cards, dealer_cards, dealer_score, player_score)
  else
    prompt "You chose to stay with: #{player_total}"
    prompt '==========================='
    player_stay += 1
    prompt 'Dealer turn...'
    dealer_turn(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  end
end
# rubocop:enable Metrics/ParameterLists

# rubocop:disable Metrics/ParameterLists
def player_turn(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  loop do
    prompt 'hit or stay? Enter h (hit) or s (stay)'
    answer = gets.chomp.downcase

    player_hits(player_cards) if answer == 'h'
    break if answer == 's' || player_bust?(player_cards)
  end

  player_wins?(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
end
# rubocop:enable Metrics/ParameterLists

def player_wins(player_cards, dealer_cards, dealer_score, player_score)
  prompt 'Dealer busts ❌'
  prompt '==========================='
  end_of_round(player_cards, dealer_cards)
  prompt 'Player wins!'
  player_score += 1
  show_game_score(dealer_score, player_score)
  game_winner?(dealer_score, player_score)
  prompt '==========================='
  dealer_score = 0 && player_score = 0 if dealer_score == 5 || player_score == 5
  play_again?(dealer_score, player_score)
end

# rubocop:disable Metrics/ParameterLists
def both_players_stay?(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  if player_stay == 1 && dealer_stay == 1
    compare_cards(player_cards, dealer_cards)
    display_results(player_cards, dealer_cards, dealer_score, player_score)
  else
    player_turn(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  end
end
# rubocop:enable Metrics/ParameterLists

# rubocop:disable Metrics/ParameterLists
def dealer_bust?(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  dealer_total = total(dealer_cards)
  if dealer_total > BUST
    player_wins(player_cards, dealer_cards, dealer_score, player_score)
  else
    prompt "Dealer chose to stay with: #{dealer_total}"
    dealer_stay += 1
    prompt '==========================='
    both_players_stay?(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
  end
end
# rubocop:enable Metrics/ParameterLists

def reset_game(dealer_score, player_score)
  system 'clear'
  player_cards = shuffle(CARDS)
  dealer_cards = shuffle(CARDS)
  player_stay = 0
  dealer_stay = 0
  initialize_game(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
end

def game_reset?(answer, dealer_score, player_score)
  case answer
  when 'y'
    reset_game(dealer_score, player_score)
  when 'n'
    prompt 'Thanks for Playing Twenty-One. Goodbye!'
  else
    prompt 'Please choose y (yes) or n (no)'
  end
end

def play_again?(dealer_score, player_score)
  answer = nil
  loop do
    prompt 'Do you want to play again? y (yes) or n (no)'
    answer = gets.chomp.downcase
    break if %w[y n].include?(answer)
  end
  game_reset?(answer, dealer_score, player_score)
end

def compare_cards(player_cards, dealer_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)
  { 'Player': player_total, 'Dealer': dealer_total }
end

def player_won(dealer_score, player_score)
  prompt 'Player wins!'
  player_score += 1
  show_game_score(dealer_score, player_score)
  game_winner?(dealer_score, player_score)
  prompt '==========================='
  dealer_score = 0 && player_score = 0 if dealer_score == 5 || player_score == 5
  play_again?(dealer_score, player_score)
end

def tie_game(dealer_score, player_score)
  prompt "It's a tie!"
  show_game_score(dealer_score, player_score)
  prompt '==========================='
  play_again?(dealer_score, player_score)
end

def dealer_won(dealer_score, player_score)
  prompt 'Dealer wins!'
  dealer_score += 1
  show_game_score(dealer_score, player_score)
  game_winner?(dealer_score, player_score)
  prompt '==========================='
  dealer_score = 0 && player_score = 0 if dealer_score == 5 || player_score == 5
  play_again?(dealer_score, player_score)
end

def end_of_round(player_cards, dealer_cards)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)
  prompt "Player ends with: #{handle_join!(player_cards).gsub('and,', '').gsub(/\s+/, ' ')} | Total: #{player_total}"
  prompt "Dealer ends with: #{handle_join!(dealer_cards).gsub('and,', '').gsub(/\s+/, ' ')} | Total: #{dealer_total}"
  prompt '==========================='
end

def display_results(player_cards, dealer_cards, dealer_score, player_score)
  player_total = total(player_cards)
  dealer_total = total(dealer_cards)
  end_of_round(player_cards, dealer_cards)

  if compare_cards(player_cards, dealer_cards)[:Player] > compare_cards(player_cards, dealer_cards)[:Dealer]
    player_won(dealer_score, player_score)
  elsif player_total == dealer_total
    tie_game(dealer_score, player_score)
  else
    dealer_won(dealer_score, player_score)
  end
end

def show_game_score(dealer_score, player_score)
  prompt "Dealer: #{dealer_score} | Player: #{player_score}"
end

def game_winner?(dealer_score, player_score)
  if dealer_score == 5
    prompt 'Dealer wins round 😎'
  elsif player_score == 5
    prompt 'Player wins round 🏆'
  end
end

initialize_game(player_cards, dealer_cards, player_stay, dealer_stay, dealer_score, player_score)
