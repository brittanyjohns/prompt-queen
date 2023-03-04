json.extract! prompt, :id, :prompt_template_id, :body, :created_by, :created_at, :updated_at
json.url prompt_url(prompt, format: :json)
