json.array!(@user_acts) do |user_act|
  json.extract! user_act, :id, :id_activity, :id_user
  json.url user_act_url(user_act, format: :json)
end
