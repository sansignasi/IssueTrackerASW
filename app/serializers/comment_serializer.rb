class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :issue_id, :user_id, :created_at, :updated_at
end
