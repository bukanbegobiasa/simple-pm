json.array!(@projects) do |project|
  json.extract! project, :id, :name, :price, :start_at, :finish_at, :active
  json.url project_url(project, format: :json)
end
