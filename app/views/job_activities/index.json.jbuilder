json.array!(@job_activities) do |job_activity|
  json.extract! job_activity, :id, :job_id, :name, :active
  json.url job_activity_url(job_activity, format: :json)
end
