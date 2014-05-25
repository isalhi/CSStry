json.array!(@mesajes) do |mesaje|
  json.extract! mesaje, :id, :id_creator, :id_activity, :title, :description
  json.url mesaje_url(mesaje, format: :json)
end
