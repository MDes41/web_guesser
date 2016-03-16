require 'sinatra'
require 'sinatra/reloader'

NUMBER = rand(100)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess)
  erb :index, :locals => { :number => NUMBER, :message => message }
end

def check_guess(guess)
  if guess > NUMBER + 5
    "Way to high!"
  elsif guess > NUMBER
    "Too High!"
  elsif guess == 0
    "Please make a valid guess"
  elsif  guess < NUMBER - 5
    "Way too low!"
  elsif guess < NUMBER && guess != 0
    "Too Low!"
  elsif guess == NUMBER
    "You got it right! The SERECT NUMBER is #{NUMBER} "
  end
end
