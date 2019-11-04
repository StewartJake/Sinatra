require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
set :secret, SECRET_NUMBER

get '/' do
    guess = params["guess"]
    message = check_guess guess.to_i
    erb :index, :locals => {:number => settings.secret, 
                            :message => message}
end

def check_guess guess
    if guess == 0
        "THE SECRET NUMBER is ***"
    elsif guess > settings.secret + 5
        "Way too high"
    elsif guess > settings.secret
        "Too high"
    elsif guess < settings.secret - 5
        "Way too low"
    elsif guess < settings.secret
        "Too low"
    else
        "THE SECRET NUMBER is " + settings.secret.to_s
    end
end
