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

# Get params from url path
get '/user-info/:name' do 
    "Hello #{params["name"]}!"
end


# CREATING A CRUD

## Model/Dataset

payloads = [{title: "First Post", body: "Content of first post"}]

# Custom Method for Getting Request Body
def getBody (req)

    ## Rewind the body in case it has already been read
    req.body.rewind
    ## parse to body
    return JSON.parse(req.body.read)
end

## Index route
get '/payloads' do
    # Return all the payloads as JSON
    return payloads.to_json
end

## Show Route
get '/payloads/:id' do
    # Return a particualr post as json based on the id param from the url
    # Params always come to a string so we convert to an integer
    id = params["id"].to_i
    return payloads[id].to_json
end

## Create Route
post '/payloads' do
    # Pass the request insto the custom getBody function
    body = getBody(request)
    # Create the new payload
    new_post = { title: body["title"], body: body["body"]}
    # Push the new payload into the array
    payloads.push(new_post)
    # Return the new payload
    return new_post.to_json
end

## Update Route
put '/payloads/:id' do
    # Get the id from params
    id = params["id"].to_i
    # Get the request body
    body = getBody(request)
    # Update the item in question
    payloads[id][:title] = body["title"]
    payloads[id][:body] = body["body"]
    # Return the updated post
    return payloads[id].to_json
end

## Delete Route
delete '/payloads/:id' do  
    # Get the id from params
    id = params["id"].to_i
    # Delete the item
    payload = payloads.delete_at(id)
    # Return the deleted item as json
    return payload.to_json
end