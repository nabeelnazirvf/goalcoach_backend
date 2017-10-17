class UserSerializer < ActiveModel::Serializer
  #root 'user'
  has_many :goals
  attributes :id, :name, :email#, :image_base
end
