json.array!(@roles) do |role|
  json.extract! role, :id, :key, :level
  json.url role_url(role, format: :json)
end
