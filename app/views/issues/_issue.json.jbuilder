json.extract! issue, :id, :Title, :Description, :Type, :Priority, :Status, :Asigned, :Creator, :Created, :Updated, :Vote, :Watch, :created_at, :updated_at
json.url issue_url(issue, format: :json)
