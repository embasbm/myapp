json.array!(@jobs) do |job|
  json.extract! job, :id, :name, :predecessor_id
  json.url job_url(job, format: :json)
end
