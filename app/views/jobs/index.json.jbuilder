json.array!(@jobs) do |job|
  json.extract! job, :id, :project_id, :title, :description, :start_at, :finish_at, :milestone, :rate, :job_status_id, :active
  json.url job_url(job, format: :json)
end
