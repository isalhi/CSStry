json.array!(@searches) do |search|
  json.extract! search, :id, :actname, :locname, :creator, :catname
  json.url search_url(search, format: :json)
end
