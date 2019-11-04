require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
WAY_OFF = "DarkRed"
CLOSE = "DarkOrange"
RIGHT_ON = "Green"

set :secret, SECRET_NUMBER
set :background, "white"

get '/' do
    guess = params["guess"]
    message = check_guess guess.to_i
    erb :index, :locals => {:number => settings.secret, 
                            :message => message,
                            :background => settings.background}
end

def check_guess guess
    if guess == 0
        "THE SECRET NUMBER is ***"
    elsif guess > settings.secret + 5
        settings.background = WAY_OFF
        "Way too high"
    elsif guess > settings.secret
        settings.background = CLOSE
        "Too high"
    elsif guess < settings.secret - 5
        settings.background = WAY_OFF
        "Way too low"
    elsif guess < settings.secret
        settings.background = CLOSE
        "Too low"
    else
        settings.background = RIGHT_ON
        "THE SECRET NUMBER is " + settings.secret.to_s
    end
end
