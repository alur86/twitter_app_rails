json.array!(@twitts) do |twitt|
  json.extract! twitt, :id, :message, :
  json.url twitt_url(twitt, format: :json)
end
