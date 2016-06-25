json.array!(@user_jobs) do |user_job|
  json.extract! user_job, :id, :user_id, :job_id
  json.url user_job_url(user_job, format: :json)
end
