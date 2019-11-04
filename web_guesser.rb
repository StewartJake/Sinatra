require 'sinatra'
require 'sinatra/reloader'

random = rand(101)

get '/' do
    "The secret number is ".upcase + random.to_s
end
