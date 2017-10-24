class UserSerializer < ActiveModel::Serializer
  has_many :goals
  attributes :id, :name, :email, :html_url, :image_base

  def html_url
    new_html_url = "http://localhost:3000/users?user_id=#{object.id}"
  end
end
