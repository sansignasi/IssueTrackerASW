json.extract! issue, :id, :title, :description, :type, :priority, :status, :assigned, :creator, :created, :updated, :vote, :watch, :created_at, :updated_at
json.url issue_url(issue, format: :json)
