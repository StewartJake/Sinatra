require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(101)

get '/' do
    guess = params["guess"]
    message = check_guess guess.to_i, secret_number
    erb :index, :locals => {:number => secret_number, 
                            :message => message}
end

def check_guess guess, actual
    if guess == 0
        "THE SECRET NUMBER is ***"
    elsif guess > actual + 5
        "Way too high"
    elsif guess > actual
        "Too high"
    elsif guess < actual - 5
        "Way too low"
    elsif guess < actual
        "Too low"
    else
        "THE SECRET NUMBER is " + actual.to_s
    end
end
