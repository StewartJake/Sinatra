require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(101)
WAY_OFF = "DarkRed"
CLOSE = "DarkOrange"
RIGHT_ON = "Green"
NORMAL = "White"

set :secret, secret_number
set :background, NORMAL

@@guesses_remaining = 5

get '/' do
    guess = params["guess"]
    cheat = params["cheat"]
    if cheat
        settings.background = "yellow"
        message = "The secret number is " + settings.secret.to_s
    else
        message = check_guess guess.to_i
    end
    erb :index, :locals => {:number => settings.secret, 
                            :message => message,
                            :background => settings.background}
end

def end_game won
    settings.secret = rand(101)
    @@gueses_remaining = 5
    if won
        "Congratulations. You've guessed it!"
    else
        "You've lost"
    end
end

def check_guess guess
    @@guesses_remaining = @@guesses_remaining - 1
    if @@guesses_remaining == 0
        return end_game false
    end
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
        return end_game true
    end
end
