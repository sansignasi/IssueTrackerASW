class IssuesSerializer < ActiveModel::Serializer
  attributes :id, :Title, :Description, :Type, :Priority, :Status,:Asigned,:Creator,:Created,:Updated
end
