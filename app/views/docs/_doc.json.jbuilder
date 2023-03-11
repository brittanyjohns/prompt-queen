json.extract! doc, :id, :name, :doc_type, :created_at, :updated_at
json.url doc_url(doc, format: :json)
