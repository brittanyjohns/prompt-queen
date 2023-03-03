json.extract! interaction, :id, :name, :interaction_type, :user_id, :created_at, :updated_at
json.url interaction_url(interaction, format: :json)
