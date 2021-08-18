json.extract! post, :id, :title, :body, :mark_for_deletion, :created_at, :updated_at
json.url post_url(post, format: :json)
