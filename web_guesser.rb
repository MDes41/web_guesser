require 'sinatra'
require 'sinatra/reloader'


get '/' do
  guess = params["guess"].to_i
  message, color = check_guess(guess)
  erb :index, :locals => { :number => @@NUMBER, :message => message, :color => color }
end

@@NUMBER = rand(100)
@@guesses = 0

def randomize
  @@guesses = 0
  @@NUMBER = rand(100)
end

def check_guess(guess)
  if guess > @@NUMBER + 5 && still_has_guesses && input_not_blank(guess)
    @@guesses += 1
    [ "Way to high!, you have #{5 - @@guesses} guesses left", "FF2400" ]
  elsif guess > @@NUMBER && still_has_guesses && input_not_blank(guess)
    @@guesses += 1
    [ "Too High!, you have #{5 - @@guesses} guesses left", "F75D59" ]
  elsif  guess < @@NUMBER - 5 && still_has_guesses && input_not_blank(guess)
    @@guesses += 1
    [ "Way too low!, you have #{5 - @@guesses} guesses left", "FF2400" ]
  elsif guess < @@NUMBER && still_has_guesses && input_not_blank(guess)
    @@guesses += 1
    [ "Too Low!, you have #{5 - @@guesses} guesses left", "F75D59" ]
  elsif guess == @@NUMBER && still_has_guesses && input_not_blank(guess)
    [ "You got it right, in #{@@guesses + 1} guesses! The SERECT NUMBER is #{@@NUMBER}", "4CC417" ]
  elsif @@guesses == 0 || !still_has_guesses || !input_not_blank(guess)
    lose_message = "Please guess a number between 0 and 100, you have #{5 - @@guesses} guesses before it resets to a new number"
    lose_message = "You ran out of guesses, a new number has been generated, guess again" if @@guesses == 5
    randomize if @@guesses == 5
    [ lose_message, "8EEBEC" ]
  end
end

def input_not_blank(guess)
  guess != 0 ? true : false
end

def still_has_guesses
  @@guesses != 5
end
