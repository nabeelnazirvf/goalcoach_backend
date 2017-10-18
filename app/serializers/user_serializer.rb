class UserSerializer < ActiveModel::Serializer
  has_many :goals
  attributes :id, :name, :email, :image_base
end
