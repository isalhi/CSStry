json.array!(@cathegories) do |cathegory|
  json.extract! cathegory, :id, :name
  json.url cathegory_url(cathegory, format: :json)
end
