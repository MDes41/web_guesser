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
  if guess > @@NUMBER + 5 && @@guesses != 5
    @@guesses += 1
    [ "Way to high!, you have #{5 - @@guesses} left", "FF2400" ]
  elsif guess > @@NUMBER && @@guesses != 5
    @@guesses += 1
    [ "Too High!, you have #{5 - @@guesses} left", "F75D59" ]
  elsif guess == 0 || @@guesses == 5
    randomize
    [ "Please make a valid guess a number between 0 and 100, you have #{5 - @@guesses} left", "8EEBEC" ]
  elsif  guess < @@NUMBER - 5 && @@guesses != 5
    @@guesses += 1
    [ "Way too low!, you have #{5 - @@guesses} left", "FF2400" ]
  elsif guess < @@NUMBER && @@guesses != 5
    @@guesses += 1
    [ "Too Low!, you have #{5 - @@guesses} left", "F75D59" ]
  elsif guess == @@NUMBER && @@guesses != 5
    [ "You got it right, in #{@@guesses + 1} guesses! The SERECT NUMBER is #{@@NUMBER}", "4CC417" ]
  end
end
