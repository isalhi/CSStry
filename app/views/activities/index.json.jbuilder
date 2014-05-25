json.array!(@activities) do |activity|
  json.extract! activity, :id, :id_creator, :id_location, :name, :date, :duration, :cathegory, :description, :privacy
  json.url activity_url(activity, format: :json)
end
