class IssuesSerializer < ActiveModel::Serializer
  attributes :id, :Title, :Description, :Type, :Priority, :Status,:Asigned,:Creator,:Created,:Updated,:file
   def file
    rails_blob_path(object.file, only_path: true) if object.file.attached?
   end
end
