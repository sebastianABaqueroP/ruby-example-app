require 'sinatra'
require 'json'
require 'sinatra/json'

# text response
get '/' do 
    'Welcome to Sinatra Framework!'
end

# html text response with css style example one
get '/greetings' do 
    "<h1>Welcome to Sinatra Framework!</h1>This is <i style='color:red'> Sinatra </i> do it my way"
end

# html text response with css style example two
get '/bye' do 
    "<h1>Good Night Sinatra Framework!</h1>This is <i style='color:blue'> Sinatra </i> sign out at #{Time.now}"
end

# simple json response
get '/json' do
    content_type :json
    data = { "text" => "Aluminium"}
    # return json { 'text': 'Aluminium'}
    data.to_json
end

# multiple json response
get '/multiple-json' do
    content_type :json
    data = { "text" => "Aluminium", "symbol" => "Al", "state" => "solid", "electronegativiy" => 1.61, "oxid-state" => 3}
    # return json { 'text': 'Aluminium'}
    data.to_json
end

# Using Sinatra-contrib -> 'sinatra/json'
# simple json response
get '/sinatra-json' do
    # return json { 'text': 'Aluminium'}
    json 'text' => 'Aluminium'
end

# Using Sinatra-contrib -> 'sinatra/json'
# multiple json response
get '/multiple-sinatra-json' do
    # return json { 'text': 'Aluminium'}
    json "text" => "Aluminium", "symbol" => "Al", "state" => "solid", "electronegativiy" => 1.61, "oxid-state" => 3
end

