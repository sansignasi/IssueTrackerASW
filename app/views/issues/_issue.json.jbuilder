<<<<<<< HEAD
json.extract! issue, :id, :title, :description, :type, :priority, :status, :asignee, :creator, :created, :updated, :vote, :watch, :created_at, :updated_at
=======
json.extract! issue, :id, :title, :description, :type, :priority, :status, :assigned, :creator, :created, :updated, :vote, :watch, :created_at, :updated_at
>>>>>>> dead917efe6133b59bc33d370aec9cc3284ad0a7
json.url issue_url(issue, format: :json)
