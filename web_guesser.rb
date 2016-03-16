require 'sinatra'
require 'sinatra/reloader'

NUMBER = rand(100)

get '/' do
  guess = params["guess"].to_i
  message, color = check_guess(guess)
  erb :index, :locals => { :number => NUMBER, :message => message, :color => color }
end

def check_guess(guess)
  if guess > NUMBER + 5
    [ "Way to high!", "FF2400" ]
  elsif guess > NUMBER
    [ "Too High!", "F75D59" ]
  elsif guess == 0
    [ "Please make a valid guess", "8EEBEC" ]
  elsif  guess < NUMBER - 5
    [ "Way too low!", "FF2400" ]
  elsif guess < NUMBER && guess != 0
    [ "Too Low!", "F75D59" ]
  elsif guess == NUMBER
    [ "You got it right! The SERECT NUMBER is #{NUMBER}", "4CC417" ]
  end
end
