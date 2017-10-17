class GoalSerializer < ActiveModel::Serializer
  belongs_to :user
  has_many :comments
  attributes :id, :title, :created_at, :email, :user_id
end
